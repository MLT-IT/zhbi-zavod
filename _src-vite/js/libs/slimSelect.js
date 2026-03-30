import SlimSelect from "slim-select"

// Значения по умолчанию
const configSelect = {
    messages: {
        placeholder: "Выберите",
        searchText: "Ничего не найдено",
        searchPlaceholder: "Поиск",
    },
}

export function initSlimSelect(selectList) {
    selectList = document.querySelectorAll(selectList)

    selectList.forEach((selectItem) => {
        const placeholder = selectItem.getAttribute("data-placeholder")
        const multiple = selectItem.hasAttribute("multiple")
        const search = selectItem.hasAttribute("data-search")
        const limit = selectItem.hasAttribute("data-limit") || 5

        new SlimSelect({
            select: selectItem,
            settings: {
                showSearch: search,
                searchText: configSelect.messages.searchText,
                searchPlaceholder: configSelect.messages.searchPlaceholder,
                placeholderText: placeholder || configSelect.messages.placeholder,
                closeOnSelect: !multiple,
                allowDeselect: multiple,
                maxValuesShown: true,
                maxValuesMessage: 'Выбрано: {number}',
                maxSelected: limit,
                openPosition: 'down',
                contentLocation: selectItem.parentNode
            }
        })
    })
}