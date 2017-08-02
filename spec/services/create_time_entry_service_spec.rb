#-- copyright
# OpenProject is a project management system.
# Copyright (C) 2012-2017 the OpenProject Foundation (OPF)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2017 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
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
#
# See doc/COPYRIGHT.rdoc for more details.
#++

require 'spec_helper'

describe CreateTimeEntryService, type: :model do
  let(:user) { FactoryGirl.build_stubbed(:user) }
  let(:contract_instance) do
    contract = double('contract_instance')
    allow(contract)
      .to receive(:validate)
      .and_return(contract_valid)
    contract
  end

  let(:contract_valid) { true }
  let(:time_entry_valid) { true }

  let(:instance) { described_class.new(user: user) }
  let(:time_entry_instance) do
    time_entry = FactoryGirl.build_stubbed(:time_entry)

    expect(time_entry)
      .to receive(:save)
      .and_return(time_entry_valid)

    time_entry
  end
  let(:params) { {} }

  before do
    allow(TimeEntries::CreateContract)
      .to receive(:new)
      .with(anything, user)
      .and_return(contract_instance)

    allow(TimeEntry)
      .to receive(:new)
      .and_return(time_entry_instance)
  end

  subject { instance.call(params) }

  it 'creates a new time entry' do
    expect(subject.result)
      .to eql time_entry_instance
  end

  it 'is a success' do
    is_expected
      .to be_success
  end

  # TODO: extend tests
end
