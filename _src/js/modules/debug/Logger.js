class Logger {
  // mode = 'dev';
  bgColors = {
    log: "#555",
    info: "#448",
    warn: "#962",
    error: "#944",
  };

  constructor() {
    try{
    const envDebug = process.env.DEBUG;
    const queryDebug = new URLSearchParams(window.location.search).get("log");
    this.debugMode = envDebug || queryDebug || false;
    console.log(`DEBUG = ${this.debugMode}: env = ${envDebug}, query = ${queryDebug}`);
      for (const [methodName, methodFunction] of Object.entries(console)) {
        this[methodName] = (...args) => {
          if (this.debugMode) {
            // console.error(`DEVMODE`);
            const method = this.custoMizeMethod(methodFunction);
            return method(...args);
          } else {
            // console.log(`PRODUCTION`);
            return () => null;
          }
        };
      }
    } catch (e) {
      console.log(`Error creating debugger`, e)
    }
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
