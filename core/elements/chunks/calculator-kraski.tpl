<div class="wrap-calc">
    <div class="calc-inputs-all">
        <div class="calc-inputs-column column-1">
            <div class="calc-input-wrap">
                <div class="calc-label-group-input">Площадь помещения:</div>
                <div class="calc-inputs">
                    <div class="calc-input">
                        <label for="length">длина, м</label><input name="length" id="length" value="" type="text" class="error">
                    </div>
                    <div class="calc-input">
                        <label for="width">ширина, м</label><input name="width" id="width" value="" type="text" class="error">
                    </div>
                </div>
            </div>
            <div class="calc-input-wrap">
                <div class="calc-label-group-input">Исключить поверхность:</div>
                <div class="calc-inputs">
                    <div class="calc-input">
                        <label for="length1">длина, м</label><input name="length1" id="length1" value="" type="text">
                    </div>
                    <div class="calc-input">
                        <label for="width1">ширина, м</label><input name="width1" id="width1" value="" type="text">
                    </div>
                </div>
            </div>
        </div>
        <div class="calc-inputs-column column-2">
            <div class="calc-input-wrap">
                <div class="calc-label-group-input">Параметры краски:</div>
                <div class="calc-inputs">
                    <div class="calc-input">
                        <label for="rashod">расход краски, м<sup>2</sup>/кг</label><input name="rashod" id="rashod" value="" type="text" class="error">
                    </div>
                    <div class="calc-input">
                        <label for="layout">кол-во слоев</label><input name="layout" id="layout" value="" type="text" class="error">
                    </div>
                    <div class="calc-input">
                        <label for="volume">объем тары, кг</label><input name="volume" id="volume" value="" type="text" class="error">
                    </div>
                </div>
            </div>
            <div class="calc-input-wrap">
                <div class="calc-label-group-input">Добавить запас:</div>
                <div class="calc-inputs">
                    <div class="calc-input">
                        <div class="calc-input-radio"><input name="add" id="add1" value="1" type="radio" checked=""><span></span></div><label for="add1">без запаса</label>
                    </div>
                    <div class="calc-input">
                        <div class="calc-input-radio"><input name="add" id="add2" value="2" type="radio"><span></span></div><label for="add2">5% запаса</label>
                    </div>
                    <div class="calc-input">
                        <div class="calc-input-radio"><input name="add" id="add3" value="3" type="radio"><span></span></div><label for="add3">10% запаса</label>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="btn btn-default btn-lg submit-calc js-submit-calc">Рассчитать расход краски</div>
    <div class="result-calc js-result-calc"></div>
    <div class="error-calc js-error-calc"></div>
</div>