
class SeleniumDaemon
    def initialize
        @flag_int = false
        @pid_file = "./selenium.pid"
        out_file = "./selenium.log"
        @out_file = File.open(out_file, "w")
    end

    def run
        begin
            @out_file.puts "[START]"

            daemonize

            set_trap

            execute

            @out_file.puts "[END]"
        rescue => e
            STDERR.puts "[ERROR][#{self.class.name}.run] #{e}"
            exit 1
        end
    end

    private

    def daemonize
        begin
            Process.daemon(true, true)

            open(@pid_file, 'w') {|f| f << Process.pid} if @pid_file
        rescue => e
            STDERR.puts "[ERROR][#{self.class.name}.daemonize] #{e}"
            exit 1
        end
    end

    def set_trap
        begin
            Signal.trap(:INT) {@flag_int =true}
            Signal.trap(:TERM) {@flag_int = true}
        rescue => e
            STDERR.puts "[ERROR] [#{self.class.name}.set_trap] #{e}"
            exit 1
        end
    end

    def execute 
        begin
            exec("java -jar selenium-server-standalone-2.41.0.jar 2>&1 &")
        rescue => e
            STDERR.puts "[ERROR] [#{self.class.name}.execute] #{e}"
            exit 1
        end
    end
end

proc = SeleniumDaemon.new
proc.run

