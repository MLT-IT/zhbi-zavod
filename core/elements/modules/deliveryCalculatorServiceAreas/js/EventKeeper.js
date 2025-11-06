class EventKeeper {
  static events = new Map();
  static trigger(event, ...params) {
    if(!this.events.has(event))return;
    const handlers = this.events.get(event);
    handlers.forEach((handler) => {
      handler(...params);
    });
  }
  static bindHandler(event, handler) {
    if(!this.events.has(event))this.events.set(event, []);
    const handlers = this.events.get(event);
    handlers.push(handler);
    this.events.set(event, handlers);
  }
}

export {
  EventKeeper
}