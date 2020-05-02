
call git add . 
call git commit -m "..."
call git push origin master 
call net stop appserver 
call flutter build web && call xcopy ".\build\web" "C:\Program Files (x86)\Store\StorewareApp\www" /E /R /Y /V
call net start appserver 