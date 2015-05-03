require 'spec_helper'

describe ApplicationHelper do
  describe '#nav_link_to' do
    it 'should add active class to link if link goes to current page' do
      controller.request.path = '/some/path'

      link_html = helper.nav_link_to 'Some page', '/some/path'
      expect(link_html).to include('class="active"')
    end

    it 'shouldnt add active class to link if it doesnt goe to current page' do
      controller.request.path = '/some/other/path'

      link_html = helper.nav_link_to 'Some page', '/some/path'
      expect(link_html).to_not include('class="active"')
    end

    it 'should preserve other css classes' do
      controller.request.path = '/some/path'

      link_html = helper.nav_link_to 'Some page', '/some/path', class: 'trueclass'
      expect(link_html).to include('active')
      expect(link_html).to include('trueclass')
    end
  end

  describe '#remote_checkbox_for' do
    let(:model) { mock(some_prop: false) }

    subject { helper.remote_checkbox_for(model, :some_prop, '/some/path', size: 'large', label: 'Hui') }

    it 'should render checkbox tag' do
      expect(subject).to have_tag('input',
        name: 'active',
        id: 'active',
        value: false,
        'data-size' => 'large',
        'data-model' => 'mock',
        'data-remote-checkbox' => 'true',
        'data-label-text' => 'Hui'
      )
    end

    context 'when size is not passed' do

      subject { helper.remote_checkbox_for(model, :some_prop, '/some/path') }

      it 'should set "mini" size' do
        expect(subject).to have_tag('input', 'data-size' => 'mini')
      end
    end
  end
end