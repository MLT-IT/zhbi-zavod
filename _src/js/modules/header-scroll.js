const header = document.querySelector('[data-header-scroll]');
const sentinel = document.querySelector('[data-header-sentinel]');

const observer = new IntersectionObserver(
  ([entry]) => {
    header.classList.toggle('is-sticky', !entry.isIntersecting);
  },
  {
    root: null,
    threshold: 0
  }
);

observer.observe(sentinel);