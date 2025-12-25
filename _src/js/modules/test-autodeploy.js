export default function testAutodeploy() {
  const params = new URLSearchParams(window.location.search);
  const value = params.get("test");
  if (value) {
    alert(`Тест автодеплоя: ${value}`);
  }
}
