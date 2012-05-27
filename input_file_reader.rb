class InputFileReader < IO

  class <<self

    def parse_input_file
      file = File.open('./mig ruby test2.txt')
      @errors = 0
      file.each do |l|
        begin
          line = l.chomp
          next unless validate(line)
        rescue
          next
        end
      end

      Error.create(:name => "Blank choice", :count => @errors)
    end

    private

    def validate(input)
      res = (input =~ /^VOTE \d+ Campaign:(\w+) Validity:(during|post|pre) Choice:(\w*) CONN:\w+ MSISDN:\d+ GUID:[\w-]+ Shortcode:\d+$/)
      return res if res.nil?

      create_or_update($1, $2, $3)
    end

    def create_or_update(compaign, validity, name)
      if(name.blank?)
        @errors += 1
        return
      end

      comp = Compaign.find_or_create_by_name(compaign)

      cand =  Candidate.find_by_name_and_compaign_id(name, comp.id)
      cand = Candidate.new(:name => name) if cand.nil?


      if(validity == "during")
        cand.counted += 1
      elsif(validity =~ /(post|pre)/)
        cand.not_counted += 1
      end

      comp.candidates << cand

    end
  end

end