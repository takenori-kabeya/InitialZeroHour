require 'timelog_controller'
require File.expand_path('../app/controllers/initial_zero_hour_timelog_controller', __FILE__)

Redmine::Plugin.register :initial_zero_hour do
  name 'Initial Zero Hour plugin'
  author 'Takenori Kabeya'
  description 'Set hours to 0 when creating timelog'
  version '0.0.1'
  url 'https://github.com/takenori-kabeya/InitialZeroHour'
  author_url 'https://cabinetwork.jp/'

  TimelogController.prepend(InitialZeroHourTimelogController)
end
