class Lyne::Account
  def initialize options
    @session   = Lyne::Session::Browser.new(options).start!
  end

  def character
    @character ||= Lyne::Page::Character::Adapter.new(@session)
  end
end
