const MAP_COVER_CLASS         = 'map-scroll-cover';
const MAP_COVER_CLASS_VISIBLE = 'map-scroll-cover--visible';
const MAP_COVER_TEXT          = 'Нажмите для прокрутки';

export default function add_cover_to_map(map_container)
{
	if (!map_container) return true;
	let mapScrollCover = document.createElement('div');
	mapScrollCover.classList.add(MAP_COVER_CLASS);
	map_container.appendChild(mapScrollCover);


	// Обработчик события прокрутки колёсика
	let map_wheel_handler = (event) =>
	{
		event.stopPropagation();

		let is_cover_visible = mapScrollCover.classList.contains(MAP_COVER_CLASS_VISIBLE);

		// Если сообщение о прокрутке ещё не показано - показываем
		if (!is_cover_visible)
		{
			mapScrollCover.innerText    = MAP_COVER_TEXT;

			/*
			mapScrollCover.style.width  = map_container.offsetWidth + 'px';
			mapScrollCover.style.height = map_container.offsetHeight + 'px';

			if (map_container.parentElement.style.position === 'relative')
			{
				mapScrollCover.style.left = '0';
				mapScrollCover.style.top  = '0';
			}
			else
			{
				mapScrollCover.style.left = map_container.offsetLeft + 'px';
				mapScrollCover.style.top  = map_container.offsetTop + 'px';
			}
            */

			mapScrollCover.classList.add(MAP_COVER_CLASS_VISIBLE);
		}
		return true;
	}


	// Курсор оказался на контейнере карты
	map_container.addEventListener(
		'mouseenter',
		(event) =>
		{
			map_container.addEventListener(
				'wheel',
				map_wheel_handler,
				{
					capture : true
				}
			);
		}
	);

	let touchstart_handler = (event) =>
	{
		event.stopPropagation();
		map_container.addEventListener(
			'touchmove',
			map_wheel_handler,
			{
				capture : true
			}
		);
	}

	map_container.addEventListener(
		'touchstart',
		touchstart_handler,
		{
			capture : true
		}
	);

	// Клик по cover'у
	mapScrollCover.addEventListener(
		'click',
		(event) =>
		{
			event.target.classList.remove(MAP_COVER_CLASS_VISIBLE);

			map_container.removeEventListener(
				'wheel',
				map_wheel_handler,
				{
					capture : true
				}
			);
			map_container.removeEventListener(
				'touchmove',
				map_wheel_handler,
				{
					capture : true
				}
			);
			map_container.removeEventListener(
				'touchstart',
				touchstart_handler,
				{
					capture : true
				}
			);
		}
	)

	// Курсор ушёл с карты
	map_container.addEventListener(
		'mouseleave',
		(event) =>
		{
			if (mapScrollCover.classList.contains(MAP_COVER_CLASS_VISIBLE))
			{
				mapScrollCover.classList.remove(MAP_COVER_CLASS_VISIBLE);
			}
		}
	)
}
