class Logger {
  mode = null;
  // mode = 'dev';
  bgColors = {
    log: "#555",
    info: "#448",
    warn: "#962",
    error: "#944",
  };

  constructor() {
    this.setQueryMode();

    for (const [methodName, methodFunction] of Object.entries(console)) {
      this[methodName] = (...args) => {
        if (this.isDevMode) {
          // console.log(`DEVMODE`);
          const method = this.custoMizeMethod(methodFunction);
          return method(...args);
        } else {
          // console.log(`PRODUCTION`);
          return () => null;
        }
      };
    }
  }

  get isDevMode() {
    // console.log(`DEBUG = ${process.env.DEBUG} (${typeof process.env.DEBUG})`);
    return process.env.DEBUG === "true" || this.mode === "dev";
  }

  getBgColor = (name) => this.bgColors[name];
  getStyle = (name) =>
    `color: white; background-color: ${this.getBgColor(
      name
    )}; padding: 2px 5px;`;

  custoMizeMethod(method) {
    if (method.name === "log") {
      const result = (...args) => {
        const [text, ...rest] = args;
        method("%c%s", this.getStyle(method.name), `LOG: ${text}`, ...rest);
      };
      // debugger;
      return result;
    }
    if (method.name === "info") {
      const result = (...args) => {
        const [text, ...rest] = args;
        method("%c%s", this.getStyle(method.name), `INFO: ${text}`, ...rest);
      };
      // debugger;
      return result;
    }
    if (method.name === "warn") {
      const result = (...args) => {
        const [text, ...rest] = args;
        method("%c%s", this.getStyle(method.name), `WARN: ${text}`, ...rest);
      };
      // debugger;
      return result;
    }
    if (method.name === "error") {
      const result = (...args) => {
        const [text, ...rest] = args;
        method("%c%s", this.getStyle(method.name), `ERROR: ${text}`, ...rest);
      };
      // debugger;
      return result;
    }
    return method;
  }

  setQueryMode = () => {
    const queryMode = new URLSearchParams(window.location.search).get("mode");
    this.mode = queryMode;
  };
}

const logger = new Logger();

export default logger;

// log
// error
// warn
// info
// table
// group
// groupEnd
// time
// timeEnd
// groupCollapsed
// assert
// dir
// count
// clear
// trace
