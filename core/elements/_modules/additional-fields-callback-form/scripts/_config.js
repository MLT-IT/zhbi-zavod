let config = {
  forms: [
    {
      id: "callback", // ID формы
      insertion: {
        element: "button[type='submit']", // Элемент рядом с которым будет вставка кнопки
        side: "before", // after or before - положение относительно insertion.element
      },
    },
    {
      id: "availability",
      insertion: {
        element: "button[type='submit']",
        side: "before",
      },
    },
  ],
};

export default config;
