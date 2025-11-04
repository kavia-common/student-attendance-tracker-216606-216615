type Listener = (event: string, data: any) => void;

class Emitter {
  private listeners: Set<Listener> = new Set();

  add(l: Listener) {
    this.listeners.add(l);
  }
  remove(l: Listener) {
    this.listeners.delete(l);
  }
  emit(event: string, data: any) {
    for (const l of Array.from(this.listeners)) {
      try {
        l(event, data);
      } catch (e) {
        // swallow
      }
    }
  }
}

const emitter = new Emitter();

// PUBLIC_INTERFACE
export function onEvent(listener: Listener) {
  emitter.add(listener);
  return () => emitter.remove(listener);
}

// PUBLIC_INTERFACE
export function publish(event: string, data: any) {
  emitter.emit(event, data);
}
