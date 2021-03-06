[![Build Status](https://api.travis-ci.org/gorn/rspreadsheet.svg?branch=master)](https://travis-ci.org/gorn/rspreadsheet) [![Coverage Status](https://coveralls.io/repos/gorn/rspreadsheet/badge.svg?branch=master&service=github)](https://coveralls.io/r/gorn/rspreadsheet)

# rspreadsheet
 
Manipulating spreadsheets with Ruby. Read, **modify**, write or create new OpenDocument Spreadsheet files from ruby code.

The gem allows you to acces your file and modify any cell of it, **without** touching the rest of the file, which makes it compatible with all advanced features of ODS files (both existing and future ones). You do not have to worry if it supports feature XY, if it does not, it won't touch it. This itself makes it distinct from most of [similar gems](#why-another-opendocument-spreadsheet-gem). Alhought this gem is still in beta stage I use in everyday and it works fine.

## Examples of usage

```ruby
sheet = Rspreadsheet.open('./test.ods').worksheets(1)

sheet.B5 = 'Cat'
sheet.B5                    #=>  'Cat'
sheet['B', 5]               #=>  'Cat'
sheet['B', 5] = 'Mouse'
sheet.row(5).cell(2).value  #=>  'Mouse'

# working with cell format
sheet.cell(5,2).format.bold = true
sheet.cell(5,2).format.background_color = '#FF0000'

# calculate sum of cells in row
sheet.row(5).cellvalues.sum
sheet.row(5).cells.sum{ |cell| cell.value.to_f }

# or set formula to a cell
sheet.cell('A1').formula='=SUM(A2:A9)'

# insert company logo to the file
sheet.insert_image_to('10mm','15mm','company_logo.png')

# iterating over list of people and displaying the data
total = 0
sheet.rows.each do |row|
  puts "Sponsor #{row[1]} with email #{row[2]} has donated #{row[3]} USD."
  total += row[3].to_f
end
puts "Totally fundraised #{total} USD"

# saving file
book.save
book.save('different_filename.ods')
```

  * Detailed [Guide to using Rspreadsheet](GUIDE.md) is available. 
  * [More examples](https://gist.github.com/gorn/b432e6a69e82628349e6) of lots of alternative syntax **you can leave you comments and suggestions there**


## Installation and Configuration

Add this line to your application's Gemfile:

```ruby
gem 'rspreadsheet'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspreadsheet

If you get any error, have a look at [troubleshooting](TROUBLESHOOTING.md)

## Contibutions, ideas and wishes welcomed

### Nonprogrammers

File a [bug report](https://github.com/gorn/rspreadsheet/issues). I appreciate any feedback and even if you can not help with code, it is interesting for me to hear from you. Different people have different needs and I want to hear about them. 

Alhought this gem is still in beta stage I use in everyday and it works fine. Any suggestions regarding the syntax is very welcomed.

### Programmers

File a [bug report](https://github.com/gorn/rspreadsheet/issues) or [fork it](http://github.com/gorn/rspreadsheet/fork) and file a pull request. You do not have to contribute a code, failing tests are welcomed as well.

## Why another OpenDocument spreadsheet gem?

I would be glad to safe myself work, but surprisingly, there are not that many gems for OpenDocument spreadsheets. Most of them also look abandoned and inactive, or can only read or write spreadsheets, but not modify them. I have investigated these options (you might as well):

  * [ruby-ods](https://github.com/yalab/ruby-ods) - this one seems abandoned, or even as if it never really started
  * [rodf](https://github.com/thiagoarrais/rodf)- this only serves as builder, it can not read existing files or modify them
  * [rods](http://www.drbreinlinger.de/ruby/rods/) - this is pretty ok, but it has terrible syntax. I first thought of writing wrapper around it, but it turned to be not so easy. Also last commit is 2 years old.
  * [rubiod](https://github.com/netoctone/rubiod) - this one is quite ok, the syntax is definitely better that in rods, but it seems also very abandoned. It does not support formats. This is a closest match.
  * [spreadsheet](https://github.com/zdavatz/spreadsheet) - this does not work with OpenDocument and even with Excel has issues in modyfying document. However since it is supposedly used, and has quite good syntax it might be inspirative. I also find the way this gem handles lazy writing of new rows to Spreadsheet object flawed, as well as strange accesibility of rows array object, which if assigned breaks consistency of sheet.
  * [roo](https://github.com/roo-rb/roo) can only read spreadsheets and not modify and write them back.

One of the main ideas is that the manipulation with OpenDOcument files should be forward compatible and as much current data preserving as possible. The parts of the file which are not needed for the change should not be changed. This is different to some of the mentioned gems, which generate the document from scratch, therefore any advanced features present in the original file which are not directly supported are lost.

## Further reading

* [Advanced Guide](GUIDE.md) how to use the gem
* [Configuration](CONFIGURATION.md) of the gem
* [Code documentation](http://www.rubydoc.info/github/gorn/rspreadsheet) is hosted on [rubydoc.info](http://www.rubydoc.info/)
* [Changelog](CHANGELOG.md)
* [Documentation for developers](DEVEL_BLOG.md) containing ideas for future development and documentation on testing tools

## License

The gem is available as open source under the terms of the [GPL licence](LICENCE.md).
