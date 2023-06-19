# frozen_string_literal: true

# Redmine - project management software
# Copyright (C) 2006-2023  Jean-Philippe Lang
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
require 'time'

module InitialZeroHourTimelogController
  def new
    @time_entry ||=
      TimeEntry.new(:project => @project, :issue => @issue,
                    :author => User.current, :spent_on => User.current.today)
    @time_entry.safe_attributes = params[:time_entry]
    @time_entry.hours = 0

    start_text_field = @time_entry.custom_field_values.detect {|c| c.custom_field.name == "開始日時"}
    return if start_text_field.nil?
    time = Time.now
    minute = ((time.min / 5.0).round) * 5
    hour = time.hour
    if minute == 60 then
      hour += 1
      minute = 0
    end
    start_text_field.value = sprintf("%d:%02d", hour, minute)
  end
end
