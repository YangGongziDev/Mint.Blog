export function setupAppErrorHandle(app: import('vue').App) {
  app.config.errorHandler = (err, vm, info) => {
    console.error(err, vm, info);
  };
}
