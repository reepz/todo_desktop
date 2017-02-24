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

## Classes
class Task
  attr_accessor :name, :status
  @@list_of_tasks = []

  def initialize(name, status = 'not done')
    @name = name
    @status = status
  end

  ## Instance methods:
  def done?
    @status == 'done'
  end

  ## Class methods:
  def self.index(order = nil)
    clear_screen
    puts "Your list contains following tasks:
    "
    if order == nil
      @@list_of_tasks.each_with_index do |task, index|
        if task.done?
          puts "done     | #{index+1}. #{task.name}"
        else
          puts "not done | #{index+1}. #{task.name}"
        end
      end
    end
    puts "\n"
  end

  def self.delete_task
    clear_screen
    Task.index
    @@list_of_tasks.delete_at(prompt("Which task do you want to delete?").to_i-1)
    clear_screen
  end

  def self.change_status
    clear_screen
    Task.index
    task = @@list_of_tasks[prompt("Which task do you want to change?").to_i-1]
    task.done? ? task.status = 'not' : task.status = 'done'
    clear_screen
  end

  def self.add_task
    clear_screen
    Task.index
    task = Task.new(prompt("Please provide name of new task:"))
    @@list_of_tasks << task
  end

  def self.change_name
    clear_screen
    Task.index
    choice = prompt("Which task do you want to rename?")
    task = @@list_of_tasks[choice.to_i-1]
    task.name = prompt("Please provide new name:")
  end

  ## for development only
  def self.create_dummy_data
    data = ['Take the trash out',
            'Replace leds in the kitchen',
            'Clean up my room',
            'Love Karolina',
            'Write g00d code',
            'COFFEE!']

    data.each do |d|
      task = Task.new(d)
      @@list_of_tasks << task
    end
  end
end

################################################################################
## Program execution:
clear_screen
Task.create_dummy_data

while true
  Task.index
  display_menu
  choice = prompt("What do you want to do?").to_i

  case choice
  when 1
    Task.add_task
  when 2
    Task.delete_task
  when 3
    Task.change_status
  when 4
    Task.change_name
  when 0
    clear_screen
    puts "Goodbye! Thank you for choosing Platformatec."
    exit
  else
    # runtime
  #   #
  # clear_screen
  end
end
