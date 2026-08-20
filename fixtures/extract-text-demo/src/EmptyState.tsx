import { resource } from '#i18n/resources/messages.msg.js';

export function EmptyState({ name }: { name: string }) {
  return (
    <div className="empty-state" data-testid="empty-state">
      <h1>{resource.get('emptyState.title')?.format()}</h1>
      <p>{resource.get('emptyState.body')?.format({ name })}</p>
      <button
        type="button"
        title={resource.get('emptyState.ctaTitle')?.format()}
      >
        {resource.get('emptyState.cta')?.format()}
      </button>
      <a href="/docs/projects">{resource.get('emptyState.learnMore')?.format()}</a>
    </div>
  );
}
