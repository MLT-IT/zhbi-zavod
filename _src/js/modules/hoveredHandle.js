
/**
 * Если у элемeнта имеется аттрибут data-hovered-event="true", то при загрузке страницe ему присвоится класс hovered
 */
document.querySelectorAll('[data-hovered-event]').forEach(elem => {
  elem.classList.add('hovered')

  elem.addEventListener('mouseleave', () => {
    elem.classList.remove('hovered')
  })
})

document.addEventListener('click', () => {
  document.querySelectorAll('.btn-icon.hovered').forEach(elem => {
    elem.classList.remove('hovered')
  })
})