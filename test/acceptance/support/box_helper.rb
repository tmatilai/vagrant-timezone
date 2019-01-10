# frozen_string_literal: true

require 'cgi'
require 'fileutils'
require 'json'
require 'open-uri'
require 'pathname'
require 'tempfile'
require 'yaml'

module VagrantTimezone
  module BoxHelper
    ROOT_DIR = Pathname.new(__dir__).join('..')
    BOX_DIR = ROOT_DIR.join('boxes')
    CONFIG_DIR = ROOT_DIR.join('config')

    def config_path(file_name)
      CONFIG_DIR.join(file_name)
    end

    def providers
      @providers ||= begin
        data = IO.read(config_path('boxes.yaml'))
        YAML.safe_load(data).map do |provider, boxes|
          Provider.new(provider, boxes)
        end
      end
    end

    def download(box)
      Downloader.download(box)
    end

    class Provider
      attr_reader :name, :boxes

      def initialize(name, box_names)
        @name = name
        @boxes = box_names.map { |box| Box.new(box, self) }
      end

      alias to_s name

      def box_dir
        @box_dir ||= BOX_DIR.join(name)
      end
    end

    class Box
      attr_reader :name, :provider

      def initialize(name, provider)
        %r{^[^/]+/[^/]+$}.match(name) ||
          raise(ArgumentError, 'Box names must be in form of <user>/<box>')

        @name = name
        @provider = provider
      end

      alias to_s name

      def path
        @path ||= provider.box_dir.join("#{sanitized_name}.box")
      end

      def sanitized_name
        name.tr('/', '_')
      end

      def metadata_url
        user, box = name.split('/')
        URI("https://app.vagrantup.com/#{CGI.escape(user)}/boxes/#{box}.json")
      end
    end

    class Downloader
      def self.download(box)
        metadata = download_metadata(box)

        url = find_url(metadata, box.provider)
        raise StandardError, "No active versions found for #{box} for #{box.provider}" if !url

        download_box(box, url)
      end

      def self.download_metadata(box)
        data = box.metadata_url.open.read
        JSON.parse(data)
      end

      def self.download_box(box, url)
        case io = url.open
        when Tempfile
          io.close
          FileUtils.mv(io.path, box.path)
        else
          IO.copy_stream(io, box.path)
        end
      end

      def self.find_url(metadata, provider)
        metadata['versions'].each do |v|
          next if v['status'] != 'active'

          v['providers'].each do |p|
            return URI(p['url']) if p['name'] == provider.name
          end
        end
      end
    end
  end
end
