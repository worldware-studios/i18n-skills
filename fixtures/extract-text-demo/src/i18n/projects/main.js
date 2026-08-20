import { MsgProject } from '@worldware/msg';

const TRANSLATION_IMPORT_PATH = "../../../res/l10n/translations";
const loader = async (project, title, language) => {
  const path = `${TRANSLATION_IMPORT_PATH}/${project}/${language}/${title}.json`;
  try {
    const module = await import(path, { with: { type: 'json' } });
    return module.default;
  } catch (error) {
    console.warn(`Translations for locale ${language} could not be loaded.`);
    return {
      title,
      attributes: { lang: language, dir: 'auto' },
      notes: [],
      messages: []
    };
  }
};

export default MsgProject.create({
  project: { name: "main", version: 1, format: "MF1" },
  locales: {
    sourceLocale: "en",
    pseudoLocale: "en-XA",
    targetLocales: {"en":["en"],"fr":["fr"],"zh":["zh"]}
  },
  loader
});
