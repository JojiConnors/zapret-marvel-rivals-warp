# Marvel Rivals — zapret / Cloudflare WARP

Русскоязычное сообщество Marvel Rivals: [@FixMarvelRivals](https://t.me/FixMarvelRivals).

> [!WARNING]
> **Это тестовая сборка.** Она проверена только на ограниченном числе
> провайдеров и компьютеров. Отдельные стратегии могут не работать либо
> увеличивать задержку. Перед запуском закройте другие версии Zapret и VPN.

Набор BAT-файлов для запуска **Marvel Rivals через Steam**, Discord и YouTube
с использованием zapret/winws2 либо Cloudflare WARP на Windows.

Адаптацию подготовил **JojiConnors**.

> Это неофициальный пользовательский проект. Он не связан с NetEase, Marvel,
> Valve или Cloudflare. Работоспособность зависит от провайдера и региона.

## Скачать

Тестовые архивы находятся на странице
[релизов](https://github.com/JojiConnors/zapret-marvel-rivals-warp/releases).

Скачайте ZIP, полностью распакуйте его в простой путь, например
`C:\zapret-marvel`, и не запускайте BAT-файлы прямо из архива.

## Что понадобится

- Windows 10 или Windows 11 x64;
- права администратора;
- Steam и установленная Marvel Rivals;
- Cloudflare One Client (WARP) — только для резервного способа через WARP;
- разрешение антивируса на запуск `winws.exe`/`winws2.exe` и драйвера WinDivert.

WinDivert — компонент перехвата и фильтрации сетевого трафика. Из-за назначения
некоторые антивирусы могут определять его как RiskTool/PUA, хотя сам по себе он
не является вирусом. Проверяйте источник скачанного архива и его SHA-256.

## Тестовый запуск без VPN/WARP

Основной экспериментальный профиль находится в папке
`Marvel-Rivals-Discord-winws2-portable`.

1. Полностью распакуйте архив.
2. Отключите VPN/WARP и остановите другие версии Zapret.
3. Запустите `1_START_MARVEL_DISCORD.bat` от имени администратора.
4. Запускайте Steam, Discord и Marvel Rivals обычным способом.
5. Для выключения запустите `2_STOP.bat`.
6. Состояние можно проверить через `3_STATUS.bat`.

Этот профиль использует `winws2`, не устанавливает постоянную службу и не
запускает игру автоматически. Первый вход в матч или стрельбище иногда занимает
10–20 секунд. Работоспособность зависит от провайдера.

## Резервный запуск через WARP

1. Запустите `1 - INSTALL Cloudflare WARP.bat`.
2. Установите официальный Cloudflare One Client.
3. В приложении выберите «Приватный просмотр» и примите условия.
4. Оставьте WARP отключённым.
5. Запустите `2 - START Marvel Rivals via WARP.bat` от имени администратора.
6. Выберите один из предложенных профилей `general`.
7. Дождитесь статуса `Connected` и оставьте чёрное окно открытым.
8. Запустите Marvel Rivals самостоятельно через Steam.
9. После игры вернитесь в чёрное окно и нажмите Enter.

У разных провайдеров работают разные профили. Если подключение не получилось,
остановите сценарий и повторите запуск с другим профилем.

## Назначение BAT-файлов

| Файл | Назначение |
| --- | --- |
| `1 - INSTALL Cloudflare WARP.bat` | Открывает официальный установщик Cloudflare WARP |
| `2 - START Marvel Rivals via WARP.bat` | Выбирает профиль zapret, включает Game Filter TCP+UDP и подключает WARP через MASQUE |
| `3 - STOP WARP and zapret.bat` | Аварийно отключает WARP, закрывает Cloudflare и удаляет службы zapret/WinDivert |
| `4 - START Marvel Rivals via WARP WireGuard.bat` | То же, что второй файл, но выбирает для WARP протокол WireGuard |
| `gagik-test.bat` | Экспериментальная стратегия Zapret 1 для Discord и YouTube; не предназначена для Marvel Rivals |

Обычно третий файл не требуется: второй BAT после нажатия Enter сам выполняет
всю очистку. Используйте аварийную остановку, если окно второго файла было
случайно закрыто крестиком.

Сценарий не запускает Steam или Marvel Rivals автоматически.

## Как это работает

Второй BAT-файл:

1. запрашивает права администратора;
2. предлагает выбрать один из имеющихся профилей `general*.bat`;
3. автоматически включает Game Filter для TCP и UDP;
4. запускает выбранную стратегию zapret;
5. выбирает для Cloudflare WARP протокол MASQUE;
6. подключает WARP и показывает состояние соединения;
7. после нажатия Enter отключает WARP, закрывает Cloudflare One Client и
   выполняет очистку zapret/WinDivert, аналогичную `Remove Services` в
   `service.bat`.

## Возможные проблемы

- Если zapret уже запущен, сначала вернитесь в старое окно запуска и нажмите
  Enter либо используйте третий BAT-файл.
- Не запускайте одновременно portable-winws2, профили `general*.bat`,
  `gagik-test.bat` и Zapret 2 GUI.
- Если WARP не подключается, попробуйте другой профиль `general`.
- Если отсутствует `winws.exe` или WinDivert, проверьте карантин антивируса.
- Если сценарий лежит в пути с кириллицей или специальными символами,
  переместите всю распакованную папку, например в `C:\zapret-marvel`.
- Этот способ не гарантирован для любого провайдера и может перестать работать
  при изменениях фильтрации или Cloudflare WARP.

Расширенная инструкция на русском и английском:
[`README - Marvel Rivals WARP.txt`](./README%20-%20Marvel%20Rivals%20WARP.txt).

## Авторы и исходные проекты

- **JojiConnors** — адаптация сценариев для Marvel Rivals и Cloudflare WARP;
- **Codex** — помощь с анализом сетевых захватов и подготовкой тестовых профилей;
- [youtubediscord/zapret](https://github.com/youtubediscord/zapret) — Windows-сборка Zapret 2, на основе которой подготовлен portable-профиль;
- [Flowseal/zapret-discord-youtube](https://github.com/Flowseal/zapret-discord-youtube) — исходная Windows-сборка и профили;
- [bol-van/zapret](https://github.com/bol-van/zapret) — оригинальный проект zapret;
- [basil00/WinDivert](https://github.com/basil00/WinDivert) — драйвер и библиотека WinDivert.

Условия распространения и уведомления об авторских правах находятся в
[`LICENSE.txt`](./LICENSE.txt).
