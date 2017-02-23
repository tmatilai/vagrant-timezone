module VagrantPlugins
    module TimeZone
        module Cap
            # Generic Windows capabilities for changing time zone
            class Windows

                # Set the time zone
                def self.change_timezone(machine, timezone)
                    offset = self.get_timezone_from_offset(timezone)

                    machine.communicate.sudo(
                    "tzutil /s \"#{offset}\"",
                    shell: 'powershell'
                    )
                end

                def self.get_timezone_from_offset(offset)
                    offset = offset.gsub(/Etc\/GMT\+?/,"")

                    return {
                        "-12"=> "Dateline Standard Time",
                        "-11"=> "UTC-11",
                        "-10"=>  "Hawaiian Standard Time",
                        "-9"=> "Alaskan Standard Time",
                        "-8"=> "Pacific Standard Time",
                        "-7"=> "Mountain Standard Time",
                        "-6"=> "Central Standard Time",
                        "-5"=> "Eastern Standard Time",
                        "-4"=> "Atlantic Standard Time",
                        "-3"=> "Greenland Standard Time",
                        "-2"=> "UTC-02",
                        "-1"=> "Azores Standard Time",
                        "0"=> "UTC",
                        "1"=> "Central Europe Standard Time",
                        "2"=> "E. Europe Standard Time",
                        "3"=> "Russian Standard Time",
                        "4"=> "Arabian Standard Time",
                        "5"=> "Pakistan Standard Time",
                        "6"=> "Central Asia Standard Time",
                        "7"=> "SE Asia Standard Time",
                        "8"=> "China Standard Time",
                        "9"=> "Tokyo Standard Time",
                        "10"=> "E. Australia Standard Time",
                        "11"=> "Central Pacific Standard Time"
                    }[offset.to_s]
                end
            end
        end
    end
end

