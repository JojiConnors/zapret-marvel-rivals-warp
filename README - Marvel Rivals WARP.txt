MARVEL RIVALS + CLOUDFLARE WARP — ИНСТРУКЦИЯ НА РУССКОМ
=======================================================

Cloudflare WARP нельзя сделать полностью портативным: он устанавливает
системную службу Windows и сетевой драйвер. Не добавляйте в архив файлы
Cloudflare из неофициальных источников.

ПЕРЕД ЗАПУСКОМ
--------------
1. Полностью распакуйте архив в простой локальный путь, например
   "C:\zapret-marvel". Не запускайте BAT-файлы прямо из ZIP или RAR.
2. Не перемещайте отдельные файлы: все файлы и папки должны оставаться вместе.
3. Для запуска необходимы права администратора.
4. Защитник Windows или другой антивирус не должен блокировать winws.exe
   и WinDivert.
5. Steam и Marvel Rivals должны быть уже установлены.

ПЕРВЫЙ ЗАПУСК НА НОВОМ КОМПЬЮТЕРЕ
---------------------------------
1. Запустите "1 - INSTALL Cloudflare WARP.bat".
2. Установите Cloudflare One Client с официального сайта Cloudflare.
3. В приложении один раз выберите «Приватный просмотр» и примите условия.
4. Оставьте WARP отключённым.
5. Запустите "2 - START Marvel Rivals via WARP.bat" от имени администратора.
6. Выберите номер одного из профилей general. У разных провайдеров могут
   работать разные профили.
7. Дождитесь статуса Connected и не закрывайте чёрное окно запуска.
8. Самостоятельно запустите Marvel Rivals через Steam и играйте.
9. После игры вернитесь в чёрное окно и нажмите Enter.
10. Скрипт отключит WARP, удалит службы zapret/WinDivert, закроет Cloudflare
    One Client, а затем закроется сам.

ОБЫЧНЫЙ ЗАПУСК
--------------
Запустите "2 - START Marvel Rivals via WARP.bat" от имени администратора и
выберите работающий у вашего провайдера профиль general. Не закрывайте чёрное
окно во время игры. После игры вернитесь в него и нажмите Enter.

АВАРИЙНАЯ ОСТАНОВКА
-------------------
Обычно всё выключается нажатием Enter в окне второго BAT-файла.
Если это окно было случайно закрыто крестиком, запустите от имени
администратора "3 - STOP WARP and zapret.bat". Он отключит и закроет WARP,
после чего удалит службы zapret и WinDivert так же, как пункт Remove Services
в service.bat.

Второй BAT-файл автоматически включает Game Filter TCP и UDP, запускает
выбранный профиль general, выбирает протокол MASQUE и подключает WARP.
Steam и Marvel Rivals он не запускает — игру нужно запускать самостоятельно.


MARVEL RIVALS + CLOUDFLARE WARP
================================

Cloudflare WARP cannot be made portable because it installs a Windows service
and a network driver. Do not add unofficial Cloudflare program files to this
archive.

BEFORE STARTING
---------------
1. Extract the entire archive to a simple local path, for example
   "C:\zapret-marvel". Do not run BAT files from inside ZIP or RAR.
2. Keep all folders and files together. Administrator rights are required.
3. Windows Security or another antivirus must not block winws.exe or WinDivert.
4. Steam and Marvel Rivals must already be installed.

FIRST RUN ON A NEW COMPUTER
---------------------------
1. Run "1 - INSTALL Cloudflare WARP.bat".
2. Install Cloudflare One Client from the official Cloudflare website.
3. In the application select "Private browsing" and accept the terms once.
4. Keep WARP disconnected.
5. Run "2 - START Marvel Rivals via WARP.bat" as administrator.
6. Select a working general zapret profile by its number.
7. Wait for Connected status and keep the launcher window open.
8. Launch Marvel Rivals manually from Steam and play.
9. When finished, return to the launcher window and press Enter.
10. The launcher disconnects WARP, removes zapret/WinDivert services, closes
    Cloudflare One Client and then closes itself.

NORMAL USE
----------
Run "2 - START Marvel Rivals via WARP.bat" as administrator.
Select the general profile that works for your Internet provider.
Keep its window open. Press Enter in that window when you finish playing.
If the window was closed accidentally, use the STOP file before starting again.

STOP
----
Normally press Enter in the second BAT window. The third BAT is an emergency
fallback if the second BAT window was closed accidentally.
Run "3 - STOP WARP and zapret.bat" as administrator when needed.
It disconnects and closes WARP, then performs the same zapret/WinDivert cleanup
as the "Remove Services" option in service.bat.

The launcher enables Game Filter TCP and UDP, starts the selected general
profile, selects MASQUE and connects WARP. It does not launch Steam or Marvel
Rivals.
