# StatusPageVi

This is an implemetation of the code challange. Nice command-line tool named ‘status_page_vi’ that pulls status information from different services, displays the results and saves it into a data store.

## Installation

 - Install Nokogiri dependencies, [instructions](http://www.nokogiri.org/tutorials/installing_nokogiri.html)

- Install it from your terminal:

  ```
  $ gem install 'status_page_vi'
  ```

## Usage

```
Commands:
  status_page_vi backup PATH RESOURCE_NAME  # takes a path variable, and creates a backup of historic and currently saved data, ALL resources by default
  status_page_vi help [COMMAND]             # Describe available commands or one specific command
  status_page_vi history RESOURCE_NAME      # display all the data which was gathered by the tool, ALL resources by default
  status_page_vi live RESOURCE_NAME         # constantly queries URL and outputs the status periodically on the console and save it to the data store, ALL resources by default
  status_page_vi pull RESOURCE_NAME         # make the application pull data from RESOURCE and save into the data store, ALL resources by default
  status_page_vi resources                  # outputs avaliable resources with urls
  status_page_vi restore PATH_TO_BACKUP     # takes a path variable which is a backup created by the application and restores that data
```

## Testing
```
$ rspec
```
