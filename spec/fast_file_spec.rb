require 'pry'
describe FastLane do
  describe FastLane::FastFile do
    describe "#initialize" do
      it "raises an error if file does not exist" do
        expect {
          FastLane::FastFile.new('./spec/fixtures/Fastfiles/FastfileNotHere')
        }.to raise_exception "Could not find Fastfile at path './spec/fixtures/Fastfiles/FastfileNotHere'".red
      end
    end

    describe "Dffferent Fastfiles" do
      it "execute different envs" do
        FileUtils.rm_rf('/tmp/fastlane/')
        FileUtils.mkdir_p('/tmp/fastlane/')

        ff = FastLane::FastFile.new('./spec/fixtures/Fastfiles/Fastfile1')
        ff.runner.execute(:deploy)
        expect(File.exists?('/tmp/fastlane/before_all')).to eq(true)
        expect(File.exists?('/tmp/fastlane/deploy')).to eq(true)
        expect(File.exists?('/tmp/fastlane/test')).to eq(false)

        ff.runner.execute(:test)
        expect(File.exists?('/tmp/fastlane/test')).to eq(true)
      end
    end
  end
end