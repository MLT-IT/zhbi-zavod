import { jsPDF } from "jspdf";
import jsPDFAutoTable from 'jspdf-autotable';
import xlsx from 'json-as-xlsx';

window.jsPDF = jsPDF;
window.jsPDFAutoTable = jsPDFAutoTable;

export default function initTableFilter(table, table_count) {
    const init = () => {
        //Обернул старую таблицу в контейнер и вывел ее на страницу
        table_actions.wrapContainer()
        table_actions.removeOldTable()
        table_actions.initNewTable()

        //После инициализации новой таблицы
        utils.all_trs = table.querySelectorAll('tr')

        table_actions.setTrIds()
        table_actions.createCheckbox()
        table_actions.createTopControlBlock()

        Array.from(table.querySelector('tr').children).forEach((child, index) => {
            if (child.className === utils.classes.row_checkbox) return

            // if (!child.classList.contains('no-sort')) {
                table_actions.createSortBtn(child, index)
            // }

            if (!child.classList.contains('no-sort')) {
                table_actions.createSelectBtn(child, index)
            }
        })
    }

    const utils = {
        classes: {
            table_wrapper: 'table-filter-container',
            row_checkbox: 'table-checkbox',
            sort_btn: 'table-sort',
            select: 'table-select',
            not_found: 'table-not-found',
            search_input: 'table-search-input',
            table_control_top: 'table-filter-top',
            download_wrapper: 'download-wrapper',
            export_btn_block: 'table-export-btn-block',
            export_btn: 'table-export-btn',
            select_list: 'select-list'
        },
        ids: {
            new_table: 'table_filter_' + table_count
        },
        elems: {
            not_found: null
        },
        filters: { //сюда попадают отфильтрованные id строк tr
            search_elems: [],
            select_elems: {}
        },
        export_table: {
            format: '',
            list: 'all',
            data: null
        },
        open_format_modal: false,
        select_line_all: false,
        error_message: null,
        active_sort_index: null,
        all_trs: null
    }

    const dom_actions = {
        create: (tag_name, attributes = {}, dataset = {}) => {
            const elem = document.createElement(tag_name)
            Object.keys(attributes).forEach(attribute_name => {
                elem[attribute_name] = attributes[attribute_name]
            })
            Object.keys(dataset).forEach(data_name => {
                elem.dataset[data_name] = dataset[data_name]
            })
            return elem
        }
    }

    const element_events = {
        selectLine(tr, select_chekbox) {
            tr.classList.toggle('select-line')
            select_chekbox.querySelector('input').checked = tr.className === 'select-line' ? true : false
        },
        selectLineAll() {
            utils.select_line_all = !utils.select_line_all
            utils.all_trs.forEach((tr, index) => {
                if (tr.hidden !== true) {
                    if (tr.getAttribute('tr-id') !== '0')
                        utils.select_line_all ? tr.classList.add('select-line') : tr.classList.remove('select-line')
                    tr.querySelector('.table-checkbox input').checked = utils.select_line_all ? true : false
                }
            })
        },
        sortRow(row_index, sort_btn) {
            //сделал через таймаут для синхронности
            table.classList.add('loading')

            if (utils.active_sort_index !== row_index && utils.active_sort_index) {
                const old_active_sort = table.querySelector(`[data-rowindex="${utils.active_sort_index}"]`)
                old_active_sort.classList.remove('asc')
                old_active_sort.classList.remove('desc')
            }

            utils.active_sort_index = row_index

            const active_sort = !!sort_btn.classList.toggle('asc')
            if (!active_sort) {
                sort_btn.classList.add('desc')
            } else {
                sort_btn.classList.remove('desc')
            }

            setTimeout(() => {
                let values = []
                utils.all_trs.forEach((tr, index) => {
                    values.push(tr.children[row_index].textContent)
                })
                const values_unique = [...new Set(values)]
                values_unique.sort((a, b) => {
                    const num_a = +a.replace(',', '.').replace('-', '.').replace(/[^0-9.]/g, '')
                    const num_b = +b.replace(',', '.').replace('-', '.').replace(/[^0-9.]/g, '')
                    if (num_a || num_b)
                        return num_a - num_b
                    else
                        return a - b
                })
                values_unique.forEach(value => {
                    utils.all_trs.forEach((tr, index) => {
                        if (tr.getAttribute('tr-id') === '0') return
                        if (tr.children[row_index].textContent === value)
                            active_sort ?
                            table.querySelector('tbody').append(tr) : table.querySelector('tr').after(tr)
                    })
                })
            }, 0)
            setTimeout(() => {
                table.classList.remove('loading')
            }, 0)

        },
        selectChange(row_index, e) {
            const select_id = e.target.id
            utils.filters.select_elems[select_id] = []

            if (e.target.value !== '')
                utils.all_trs.forEach(tr => {
                    const tr_id = tr.getAttribute('tr-id')
                    if (tr_id === '0') return
                    if (tr.children[row_index].textContent === e.target.value) {
                        utils.filters.select_elems[select_id].push(tr_id)
                    }
                })
            else
                delete utils.filters.select_elems[select_id]

            startFilter()
        },
        inputSearch(e) {
            utils.filters.search_elems = []

            utils.all_trs.forEach(tr => {
                const tr_id = tr.getAttribute('tr-id')
                if (tr_id === '0') return
                Array.from(tr.children).forEach(child => {
                    if (child.textContent.indexOf(e.target.value) > -1) {
                        utils.filters.search_elems.push(tr_id)
                    }
                })
            })

            //Если ничешго не найдено при введеном в поиск слове - выдать ошибку
            if (e.target.value !== '' && !utils.filters.search_elems.length) {
                utils.all_trs.forEach(tr => {
                    if (tr.getAttribute('tr-id') === '0') return
                    tr.hidden = true
                })
                table_actions.filterNotFound.create()
                return
            } else {
                // table_actions.filterNotFound.remove()
                startFilter()
            }

            // startFilter()

        },
        selectClick(row_index, select) {
            if (select.children.length > 1) return
            let values = []
            utils.all_trs.forEach((tr, index) => {
                if (tr.getAttribute('tr-id') === '0') return
                values.push(tr.children[row_index].textContent)
            })
            const values_unique = [...new Set(values)]
            values_unique.sort((a, b) => {
                const num_a = +a.replace(',', '.').replace('-', '.')
                const num_b = +b.replace(',', '.').replace('-', '.')
                if (num_a || num_b)
                    return num_a - num_b
                else
                    return a - b
            })
            values_unique.forEach(value => {
                const option = dom_actions.create('option', {
                    innerHTML: value
                })

                select.append(option)
            })
        },
    }


    const table_actions = {
            wrapContainer() {
                const wrapper = dom_actions.create('div', {
                    className: utils.classes.table_wrapper,
                    innerHTML: `<table id="${utils.ids.new_table}">${table.innerHTML}</table>`
                })

                table.before(wrapper)
            },
            removeOldTable() {
                table.remove()
            },
            initNewTable() {
                table = document.getElementById(utils.ids.new_table)
            },
            createCheckbox() {
                utils.all_trs.forEach((tr, index) => {
                    const select_chekbox = dom_actions.create('td', {
                        className: utils.classes.row_checkbox,
                        innerHTML: `<div class="th-inner">
                              <input type="checkbox" tabindex=${index} ${index === 0}/>
                            </div>`
                    }, {
                        table_checkbox: true
                    })
                    if (tr.getAttribute('tr-id') === '0')
                        select_chekbox.onclick = () => element_events.selectLineAll()
                    else
                        tr.onclick = () => element_events.selectLine(tr, select_chekbox)

                    tr.prepend(select_chekbox)
                })

            },
            createSortBtn(child, index) {
                const sort_btn = dom_actions.create('div', {
                    className: utils.classes.sort_btn,
                    innerHTML: child.textContent,
                    onclick: () => element_events.sortRow(index, sort_btn)
                }, {
                    rowindex: index,
                    header: true
                })

                child.innerHTML = ''
                child.append(sort_btn)
            },
            createSelectBtn(child, index) {
                const select = dom_actions.create('select', {
                    className: utils.classes.select,
                    innerHTML: '<option value="">Выбрать</option>',
                    id: 'select_' + index,
                    onchange: (e) => element_events.selectChange(index, e),
                    onclick: () => element_events.selectClick(index, select) //Заполнил селект значениями
                })

                child.append(select)
            },
            createTopControlBlock() {
                const input = dom_actions.create('input', {
                    className: utils.classes.search_input,
                    placeholder: 'Найти...',
                    type: 'text',
                    oninput: (e) => element_events.inputSearch(e)
                })

                const select_list = dom_actions.create('select', {
                    innerHTML: `
                <option value="all">Скачать все</option>
                <option value="selected">Скачать выбранные</option>`,
                    onchange: (e) => export_actions.changeList(e)
                })

                const export_btn = dom_actions.create('div', {
                    className: utils.classes.export_btn_block,
                    innerHTML: `
                <button class="${utils.classes.export_btn}"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" fill="#3a3a3a"><path d="M480 352h-133.5l-45.25 45.25C289.2 409.3 273.1 416 256 416s-33.16-6.656-45.25-18.75L165.5 352H32c-17.67 0-32 14.33-32 32v96c0 17.67 14.33 32 32 32h448c17.67 0 32-14.33 32-32v-96C512 366.3 497.7 352 480 352zM432 456c-13.2 0-24-10.8-24-24c0-13.2 10.8-24 24-24s24 10.8 24 24C456 445.2 445.2 456 432 456zM233.4 374.6C239.6 380.9 247.8 384 256 384s16.38-3.125 22.62-9.375l128-128c12.49-12.5 12.49-32.75 0-45.25c-12.5-12.5-32.76-12.5-45.25 0L288 274.8V32c0-17.67-14.33-32-32-32C238.3 0 224 14.33 224 32v242.8L150.6 201.4c-12.49-12.5-32.75-12.5-45.25 0c-12.49 12.5-12.49 32.75 0 45.25L233.4 374.6z"/></svg></button>
                <ul class="${utils.classes.select_list}" select-list>
                <li select-format data-value="excel">EXCEL</li>
                <li select-format data-value="csv">CSV</li>
                <li select-format data-value="pdf">PDF</li>
                </ul>
                `
                })

                export_btn.querySelector('button').onclick = () => {
                    export_btn.querySelector('[select-list]').classList.toggle('opened')
                }

                export_btn.querySelectorAll('[select-format]').forEach(select_format => {
                    select_format.onclick = (e) => {
                        export_actions.changeFormat(e)
                        export_btn.querySelector('[select-list]').classList.remove('opened')
                    }
                })

                const download_wrapper = dom_actions.create('div', {
                    className: utils.classes.download_wrapper,
                })

                const wrapper = dom_actions.create('div', {
                    className: utils.classes.table_control_top,
                })

                download_wrapper.append(select_list)
                download_wrapper.append(export_btn)

                wrapper.append(download_wrapper)
                wrapper.append(input)

                table.parentNode.before(wrapper)
            },
            setTrIds() {
                utils.all_trs.forEach((tr, index) => tr.setAttribute('tr-id', index))
            },
            filterNotFound: {
                create() {
                    if (utils.elems.not_found) return
                    const not_found = dom_actions.create('tr', {
                        className: utils.classes.not_found,
                        innerHTML: '<td colspan="100">По выбранным фильтрам ничего не найдено</td>'
                    })
                    utils.elems.not_found = not_found
                    table.querySelector('tbody').append(not_found)
                },
                remove() {
                    if (!utils.elems.not_found) return
                    utils.elems.not_found.remove()
                    utils.elems.not_found = null
                }
            }
        }
        //
    const export_actions = {
        changeFormat(e) {
            this.getData()
            switch (e.target.getAttribute('data-value')) {
                case 'excel':
                    this.formatEXCEL()
                    break;
                case 'csv':
                    this.formatCSV()
                    break;
                case 'pdf':
                    this.formatPDF()
                    break;
            }
        },
        changeList(e) {
            utils.export_table.list = e.target.value
        },
        getData() {
            const result = { header: [], data: [] }
            switch (utils.export_table.list) {
                case 'all':
                    utils.all_trs.forEach(tr => {
                        let child_data = {}
                        Array.from(tr.children).forEach((child, index) => {
                            if (tr.getAttribute('tr-id') === '0' && !child.getAttribute('data-table_checkbox'))
                                result.header.push(child.querySelector('[data-header=true]').textContent)
                            else if (index !== 0)
                                child_data[result.header[index - 1]] = child.textContent
                        })

                        result.data.push(child_data)
                    })
                    break;
                case 'selected':
                    utils.all_trs.forEach(tr => {
                        if (tr.className === 'select-line' || tr.getAttribute('tr-id') === '0') {
                            let child_data = {}
                            Array.from(tr.children).forEach((child, index) => {
                                if (tr.getAttribute('tr-id') === '0' && !child.getAttribute('data-table_checkbox'))
                                    result.header.push(child.querySelector('[data-header=true]').textContent)
                                else if (index !== 0)
                                    child_data[result.header[index - 1]] = child.textContent
                            })

                            if (tr.className === 'select-line')
                                result.data.push(child_data)
                        }
                    })
                    break;
            }

            utils.export_table.data = result
        },
        formatCSV() {
            const keys = Object.keys(utils.export_table.data.data[1]);
            let data = keys.join(";") + "\n";

            utils.export_table.data.data.forEach(obj => {
                keys.forEach((k, ix) => {
                    if (ix) data += ";";
                    data += obj[k];
                });
                data += "\n";
            });

            this.export(data, 'export.csv')
        },
        formatEXCEL() {
            const new_data = [{}]
            new_data[0].columns = []
            new_data[0].content = utils.export_table.data.data

            utils.export_table.data.header.forEach(column_title => {
                new_data[0].columns.push({ label: column_title, value: column_title })
            })

            let settings = {
                fileName: "export",
                extraLength: 3,
                writeOptions: {},
            }

            xlsx(new_data, settings)
        },
        formatPDF() {
            const body = []
            utils.export_table.data.data.forEach(object_elem => {
                body.push(Object.values(object_elem))
            })
            const doc = new jsPDF()

            var font = window.pdffont;

            doc.addFileToVFS('Roboto-Regular-normal.ttf', font);
            doc.addFont('Roboto-Regular-normal.ttf', 'Roboto-Regular', 'normal');
            doc.setFont('Roboto-Regular');

            jsPDFAutoTable(doc, {
                head: [
                    utils.export_table.data.header
                ],
                body,
                styles: {
                    font: 'Roboto-Regular',
                    fontStyle: 'normal',
                }
            })

            doc.save('export.pdf')
        },
        export (data, file_name) {
            let a = document.createElement("a");
            let file = new Blob([data], { type: 'application/json' });
            a.href = URL.createObjectURL(file);
            a.download = file_name;
            a.click();
        },
        // formatXML() {
        //     function OBJtoXML(obj) {
        //         var xml = '';
        //         for (var prop in obj) {
        //             xml += obj[prop] instanceof Array ? '' : "<" + prop + ">";
        //             if (obj[prop] instanceof Array) {
        //                 for (var array in obj[prop]) {
        //                     xml += "<" + prop + ">";
        //                     xml += OBJtoXML(new Object(obj[prop][array]));
        //                     xml += "</" + prop + ">";
        //                 }
        //             } else if (typeof obj[prop] == "object") {
        //                 xml += OBJtoXML(new Object(obj[prop]));
        //             } else {
        //                 xml += obj[prop];
        //             }
        //             xml += obj[prop] instanceof Array ? '' : "</" + prop + ">";
        //         }
        //         var xml = xml.replace(/<\/?[0-9]{1,}>/g, '');
        //         return xml
        //     }

        //     this.export('<?xml version="1.0" encoding="utf-8"?> <tabledata>' + OBJtoXML(utils.export_table.data) + '</tabledata>', 'export.xml')
        // },
        // formatJSON() {
        //     let data = JSON.stringify(utils.export_table.data);
        //     this.export(data, 'export.json')
        // }
    }

    const startFilter = () => {

        table_actions.filterNotFound.remove()

        let result = []
        let select_ids = []
        let search_ids = []
        const keys_select_elems = Object.keys(utils.filters.select_elems)

        //Если ничего не выбрано
        if (!keys_select_elems.length && !utils.filters.search_elems.length) {
            utils.all_trs.forEach(tr => {
                if (tr.getAttribute('tr-id') === '0') return
                tr.hidden = false
            })
            return
        }

        //Разобрали массив элементов собранных через select`ы
        //Беру перввый айдишники из первого фильтра и бегу с ними по всем фиьтрам
        //Если id из первого фильтра есть во всех остальных значит строку с данным id оставляем
        if (keys_select_elems.length > 1) {
            const first_select_array_ids = utils.filters.select_elems[keys_select_elems[0]]
            first_select_array_ids.forEach(first_select_id => {
                let count_match = 0
                keys_select_elems.forEach(key => {
                    const next_select_ids = utils.filters.select_elems[key]
                    next_select_ids.forEach(next_select_id => {
                        if (next_select_id === first_select_id) count_match++
                    })
                })

                //Значит id из массива айдишников первого выбранного фильтра есть во всех выбранных фильтрах
                if (count_match === keys_select_elems.length) select_ids.push(first_select_id)
            })
        } else
            keys_select_elems.forEach(select_id => {
                select_ids.push(...utils.filters.select_elems[select_id])
            })

        //Разобрали массив элементов собранных через search
        utils.filters.search_elems.forEach(tr_id => {
            search_ids.push(tr_id)
        })
        search_ids = [...new Set(search_ids)]

        result = result.concat(select_ids, search_ids)

        if (keys_select_elems.length && utils.filters.search_elems.length)
            result = result.filter((elem, index) => result.indexOf(elem) !== index)

        let not_found = true
        utils.all_trs.forEach(tr => {
            if (tr.getAttribute('tr-id') === '0') return
            if (result.indexOf(tr.getAttribute('tr-id')) > -1) {
                tr.hidden = false
                not_found = false
            } else
                tr.hidden = true
        })

        if (not_found)
            table_actions.filterNotFound.create()
    }

    init()
}
