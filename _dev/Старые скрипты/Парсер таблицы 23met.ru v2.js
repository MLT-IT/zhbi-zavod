jq = document.createElement('script');
jq.src = "https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js";
document.getElementsByTagName('head')[0].appendChild(jq);


setTimeout(function () {
    // Определяем функцию
    function getTable() {
        let $table = $('#weights-table');
        let $newTable = $('<table></table>');

        $table.find('tr').each(function (i, tr) {
            let $newTr = $('<tr></tr>');
            let $tr = $(tr);
            let $wcont = $tr.find('td').eq(1).find('.calc_w_container');

            let val1 = $tr.find('td').eq(0).find('.wt-link').text();
            let val2 = $wcont.find('input').val();
            let val3 = $wcont.find('.calc_field_label').text();

            $newTr.append('<td>' + val1 + '</td>');
            $newTr.append('<td>' + val2 + ' ' + val3 + '</td>');

            $newTable.append($newTr);
        });

        $newTable.wrap('<div class="wrapper"></div>');
        $newTable = $newTable.parent();
        return $newTable.html();
    }

    console.log(getTable());
}, 2000);

