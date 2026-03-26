import collapseLongTexts from "./collapseLontTexts";

function fixReviewsTabCollapseLongText() {
  const infoblocks = document.querySelector('.infoblocks__container');
  if(!infoblocks)return;
  infoblocks.addEventListener('change-tab', function(e) {
      console.log('Tab changed!');
      const activeTabReviews = document.querySelector('.infoblocks__tab.active[data-tab="Отзывы"]');
      if(!activeTabReviews)return;
      setTimeout(() => {
          collapseLongTexts();
      }, 100)
  });
}

export {
  fixReviewsTabCollapseLongText
}