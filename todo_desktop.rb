## Global methods
def clear_screen
  system('cls')
end

def prompt(prompt_text = nil)
  puts prompt_text
  print '> '
  choice = gets.chomp
end

def display_menu
  puts '
    Menu:
    1. Add task
    2. Delete task
    3. Change task status
    4. Change task name
  '
end

## #### for development only
def create_dummy_data
  @mylist = List.new
  data = ['Take the trash out',
          'Replace leds in the kitchen',
          'Clean up my room',
          'Love Karolina',
          'Write g00d code',
          'COFFEE!']

  data.each do |d|
    task = Task.new(d)
    @mylist.add_task(task)
  end
end

## Classes

# List class
class List
  attr_reader :all_tasks

  def initialize
    @all_tasks = []
  end

# Instance methods:
  def add_task(task)
    all_tasks << task
  end

  def display_all_tasks
    clear_screen
    puts "Your list contains the following tasks:
    "
    all_tasks.each_with_index do |task, index|
      if task.done?
        puts "done     | #{index+1}. #{task.name}"
      else
        puts "not done | #{index+1}. #{task.name}"
      end
    end
  end
  puts "/n"

  def delete_task
    display_all_tasks
    puts "Which task do you want to delete?"
    choice = gets.chomp
    all_tasks.delete_at(choice.to_i - 1)
  end
end

# Task class
class Task
  attr_accessor :name, :status

  def initialize(name, status = 'not done')
    @name = name
    @status = status
  end

  ## Instance methods:
  def done?
    @status == 'done'
  end

  def change_status
    if status == 'done'
      @status = 'not done'
    else
      @status = 'done'
    end
  end

  def change_name(name)
    @name = name
  end
end

################################################################################
## Program execution:

clear_screen
create_dummy_data

while true

  @mylist.display_all_tasks
  display_menu

  choice = prompt("What do you want to do?").to_i

  case choice
  when 1
    @mylist.add_task(Task.new(prompt("Please provide name of the new task")))
  when 2
    @mylist.delete_task
  when 3
    @mylist.display_all_tasks
    puts "Which task name do you want to change?"
    choice = gets.chomp
    task = @mylist.all_tasks[choice.to_i - 1]
    task.change_status
  when 4
    @mylist.display_all_tasks
    puts "Which task name do you want to change?"
    choice = gets.chomp
    task = @mylist.all_tasks[choice.to_i - 1]
    puts "Please provide new name"
    new_name = gets.chomp
    task.name = new_name
  when 0
    clear_screen
    puts "Goodbye! Thank you for choosing Platformatec."
    exit
  else
    #
  end
end
