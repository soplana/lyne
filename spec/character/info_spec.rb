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
        character_id: @account[:character_id][0]
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

    context 'Houseが取得できているる' do
      subject{ @character.house }

      context 'cityが取得できている' do
        it { expect(subject.city).to match(/.*住宅村$/) }
      end

      context 'house_numberが取得できている' do
        it { expect(subject.house_number).to match(/.*サイズ）$/) }
      end
    end

    if YAML.load_file("./spec/account.yaml")['account']['character_id'][1]
      context 'キャラチェンジできる' do
        before(:all) do
          @id = @character.info.id
          @other_character = @character.change(@account[:character_id][1])
        end
        subject{ @other_character.info }

        context 'キャラチェンジ後とinfo.idが違う' do
          it { expect(subject.id).not_to match(@id) }
        end
      end
    end

  end
end
