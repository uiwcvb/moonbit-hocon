import {Config} from './product/tools/config.mjs';
const settings = Config.load('build=9007199254740995');
const narrowed: number = settings.getLong('build');
settings.getInt(1);
settings.root().clear();
Config.load('x=1', {getter: 'int'});
