require File.expand_path(File.join('../', 'spec_helper'), File.dirname(__FILE__))

describe Lyne::Page::Character do
  before(:all){ @account = YAML.load_file("./spec/account.yaml")['account'].symbolize_keys }

  context 'character情報' do
    let(:property){ nil }
    # ほんとはletがいいけど, 一度しか実行したくない...
    before(:all) do
      dqx = Lyne::Account.new({
        account:      @account[:name],
        password:     @account[:password],
        character_id: @account[:character_id]
      })
      @character = dqx.character
    end

    context 'Infoが取得できているる' do
      subject{ @character.info }

      context 'IDが取得できている' do
        it { expect(subject.id).to match(/^[a-z]{2}\d{3}-\d{3}$/i) }
      end

      context 'levelが取得できている' do
        it { expect(subject.level).to match(/^\d*$/) }
      end

      context 'next_levelが取得できている' do
        it { expect(subject.next_level).to match(/.*P$/) }
      end

      context 'goldが取得できている' do
        it { expect(subject.gold).to match(/.*G$/) }
      end
    end
  end
end
