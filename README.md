# Lyne
スクエアエニックスが運営するドラゴンクエスト10のメンバーズサイト「冒険者の広場」をスクレイピングするgemです.

# install

内部でphantomjsを使ってスクレイピングするためinstallしてください.

http://phantomjs.org/download.html

```bash
# osx
$ brew update && brew install phantomjs
```

# use

```bash
$ gem install lyne
```
```
gem 'lyne'
```

optionで渡すcharacter_idはキャラクター選択画面の「このキャラを選択」ボタンのrel属性の値になります。

![character_id](http://dl.dropboxusercontent.com/u/92653510/DQ10/charaid.png "character_id")

```ruby
require 'lyne'

dqx = Lyne::Account.new(
  account:      'account_name',
  password:     'account_password',
  character_id: 975829418411224
)

chara = dqx.character
```

### Info Class

```ruby
info = chara.info
info.id   #=> "TV327-610"
info.name #=> "ソプラナ"
# フレンド申請おｋ
```

```
# id name job tribe level next_level gold genki_charge

> info.show_table

+---------+--------+--------------+------+------+--------------+----------+------------+
|ID       |名前    |職業          |種族  |レベル|次のレベルまで|所持金    |元気チャージ|
+---------+--------+--------------+------+------+--------------+----------+------------+
|TV327-610|ソプラナ|バトルマスター|エルフ|80    |              |2,340,609G|209時間     |
+---------+--------+--------------+------+------+--------------+----------+------------+
```

### House Class

```ruby
house = chara.house
house.city         #=> "アズラン住宅村"
house.area         #=> "おごそかな林道地区"
house.house_number #=> "3849丁目 6番地 （Ｓサイズ）"
# 遊びにきておｋ
```

```
# city area house_number setting setting_type

> house.show_table

+--------------+------------------+-------------------------+----------------------+------------------------+
|町            |地区              |番地                     |ウェルカム設定        |設定内容                |
+--------------+------------------+-------------------------+----------------------+------------------------+
|アズラン住宅村|おごそかな林道地区|3849丁目6番地（Ｓサイズ）|ウェルカムハウス設定中|インテリアじまん・その他|
+--------------+------------------+-------------------------+----------------------+------------------------+
```

### キャラチェンジ

```ruby
chara = dqx.character
chara.change('122233333444') #=> character_idを指定
```

# test

```bash
$ cp spec/account.yaml.example spec/account.yaml
```

```yaml
# spec/account.yaml
account:
  name:         account_name
  password:     account_password
  character_id: 975829418411224
```

```
$ rspec spec/character/info_spec.rb
```
