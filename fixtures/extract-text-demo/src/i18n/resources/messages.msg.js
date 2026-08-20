/** ESM module **/

import { MsgResource, getLang } from '@worldware/msg';
import project from '#i18n/projects/main.js';

/** Create a MsgResource object */

export const resource = MsgResource.create({
    title: 'messages',
    attributes: {
      lang: 'en',
      dir: 'ltr'
    },
    notes: [
      {type: 'DESCRIPTION', content: 'This is the messages resource.'}
    ]
  }, project);

/**
 * Add messages to the resource using add(key, value, attributes, notes)
 * The add method is chainable.
 */

resource
    .add('emptyState.title', 'No projects yet')
    .add('emptyState.body', 'Create your first project to get started, {name}.', {}, [
      { type: 'PARAMETERS', content: 'The {name} parameter holds the user name.' }
    ])
    .add('emptyState.cta', 'Create project')
    .add('emptyState.ctaTitle', 'Starts the create-project wizard')
    .add('emptyState.learnMore', 'Learn more');

/**
 * An async function to get a translated version of the resource
 * If the runtime language has not been set using `setLang()`,
 * it will return the original resource
 */
export async function getMessages() {
  return await resource.getTranslation(getLang());
}
