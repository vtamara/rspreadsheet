require 'spec_helper'

describe Rspreadsheet::Workbook do
  it 'has correct number of sheets' do
    book = Rspreadsheet.new($test_filename)
    book.worksheets_count.should == 1
    book.worksheets[0].should be_nil
    book.worksheets[1].should be_kind_of(Rspreadsheet::Worksheet)
    book.worksheets[2].should be_nil
    book.worksheets[nil].should be_nil
  end
  it 'freshly created has correctly namespaced xmlnode' do
    @xmlnode = Rspreadsheet.new.xmlnode
    @xmlnode.namespaces.to_a.size.should >5
    @xmlnode.namespaces.find_by_prefix('office').should_not be_nil
    @xmlnode.namespaces.find_by_prefix('table').should_not be_nil
    @xmlnode.namespaces.namespace.prefix.should == 'office'
  end
end