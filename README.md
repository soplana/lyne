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
$ gem install Lyne
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

info = dqx.character.info
info.id   #=> "TV327-610"
info.name #=> "ソプラナ"
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
