require 'spec_helper'

describe "ArcFile" do
  before :all do
  end

  describe "#open" do

    it "should open an existing arc file" do
      file = ArcFile.open("spec/1341826131693_45.arc")
      file.version.should == "1"
      file.source.should == "CommonCrawl"      

      firstrecord = file.next_record
      firstrecord.url.should == "http://www.blackporno4u.com/black/ass-black-nude.html"
      firstrecord.ip_address.should == "67.18.100.212"
      firstrecord.archive_date.should == DateTime.new(2012, 5, 23, 1, 38, 23)
      firstrecord.content_type.should == "text/html"
      firstrecord.length.should == 13713 

      firstrecord.seek_to_end()
      secondrecord = file.next_record
      secondrecord.url.should == "http://www.mlclothing.co.uk/item/DG_DGLightWashLeaderComfortFitJeans_0_531_3888_1.html"
      secondrecord.ip_address.should == "89.145.68.181"
      secondrecord.archive_date.should == DateTime.new(2012, 5, 23, 1, 38, 23)
      secondrecord.content_type.should == "text/html"
      secondrecord.length.should == 451

      secondrecord.seek_to_end()
      thirdrecord = file.next_record
      thirdrecord.url.should == "http://www.applicationperformance.com/news-and-events/news/394-launch-of-new-automation-tool-for-software-development-and-maintenance-of-saas-applications"
      thirdrecord.ip_address.should == "79.125.11.143"
      thirdrecord.archive_date.should == DateTime.new(2012, 5, 23, 1, 38, 23)
      thirdrecord.content_type.should == "text/html"
      thirdrecord.length.should == 26766

      thirdrecord.seek_to_end()
      looprecord = file.next_record
      i = 0
      while(looprecord)
        i = i + 1
        looprecord.url.should_not be_empty
        (/[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*/=~looprecord.ip_address).should == 0
        looprecord = file.next_record
      end
      i.should == 7188
     
      i = 0
      chars = ""
      d = thirdrecord.data
      while !chars.nil?
        i = i + chars.length
        chars = d.read(256)
      end
      i.should == thirdrecord.length
    end

  end

end
