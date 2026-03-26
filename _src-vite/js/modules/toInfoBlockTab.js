export default function toInfoBlockTab(name) {
  const tab = document.querySelector('.infoblocks__tab[data-tab="'+ name +'"]');
  if(!tab)return;
  tab.click();

  const element = tab;
  const offset = -90; // Прокрутить чуть выше, чтобы были видна названия табов
  const elementPosition = element.getBoundingClientRect().top + window.pageYOffset + offset;
  window.scrollTo({
    top: elementPosition
  });
}