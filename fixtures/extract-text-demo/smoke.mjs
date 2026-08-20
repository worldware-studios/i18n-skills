import { resource } from './src/i18n/resources/messages.msg.js';

console.log('keys', [...resource.keys()]);
console.log('title', resource.get('emptyState.title')?.format());
console.log('body', resource.get('emptyState.body')?.format({ name: 'Ada' }));
