        <div class="infoblocks__block active" data-tab-page="Характеристики">
          <button class="infoblocks__block-title" data-tab="Характеристики">Характеристики</button>
          <div class="infoblocks__block-dropdown">
            <div class="table infoblocks__table">
              <table class="table__table">
                <tbody>
                  {'msProductOptions' | snippet : [
                    'tpl' => '@FILE chunks/item-characters.tpl',
                    'ignoreOptions' => 'edizm,edizm2'
                  ]}
                </tbody>
              </table>
            </div>
          </div>
        </div>
