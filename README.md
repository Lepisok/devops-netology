1. Установлено
2. Установлено
3. Насроено
4. Запущено
5. Base memory: 1024 MB
   Processor: 2
   Video Memory: 4MB
6. config.vm.provider "virtualbox" do |v|
   v.memory = 1024
   v.cpus = 2
   end
7. готово
8. history_length (строки 375-376)
   The number of entries currently stored in the history list.
   и
   history_max_entries (строки 378-380)
   The maximum number of history entries.  This must be changed using sti‐
   fle_history()
   ignoreboth состоит из двух команд:
   1) ignorespace - если команда начинается с пробела, не сохранять её
   2) ignoredups - не сохранять команду, если она уже есть в истории
9. {} - список, цикличекое выполнение команды от первого значения до второго
   Строка(330)
10.100000 файлов - будет создано
   300000 файлов - создан не будет, листр аргументов слишком большой
11.Будет проверять, есть ли данная директория
12.Сначала создадим папку mkdir /tmp/new_path_directory/
   скопируем туда папку cp /bin/bash /tmp/new_path_directory/
   PATH=/tmp/new_path_directory/:$PATH
   type -a bash
13.at - одноразовое задание в заданное время
   batch - одноразовое задание, будет выполняться только при условии, когда загрузка системы меньше >
14.vagrant suspend
