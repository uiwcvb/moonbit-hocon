import type {SecureContextOptions} from 'node:tls';

/** Detached JSON data. Numeric JSON output follows JavaScript double precision. */
export type JsonValue = null | boolean | number | string | JsonValue[] | JsonObject;
export interface JsonObject { [key: string]: JsonValue }
export type JsonInput = null | boolean | number | string | readonly JsonInput[] | {readonly [key: string]: JsonInput};
export type DoubleValue = number | 'NaN' | 'Infinity' | '-Infinity';
export type DurationUnit = 'nanoseconds' | 'microseconds' | 'milliseconds' | 'seconds' | 'minutes' | 'hours' | 'days';
export type ValueType = 'OBJECT' | 'LIST' | 'STRING' | 'NUMBER' | 'BOOLEAN' | 'NULL';
export interface SourcePosition {source: string; offset: number; line: number; column: number}
export interface ValidationProblem {path: string; kind: string; expected: string; actual: string}
export interface ConfigPeriod {years: number; months: number; days: number}
export type TemporalAmount = {kind: 'duration'; nanoseconds: string} | ({kind: 'period'} & ConfigPeriod);
export type ConfigNumber = {kind: 'int' | 'long'; value: string} | {kind: 'double'; value: DoubleValue | '-0.0'; bits: string};
export interface ReadReceipt {readonly path: string; readonly bytes: number; readonly sha256: string}
export interface NetworkOptions {
  timeoutMs?: number;
  totalTimeoutMs?: number;
  maxResponseBytes?: number;
  maxRedirects?: number;
  ca?: SecureContextOptions['ca'];
}
export interface FallbackSource {name: string; content: string; format?: 'hocon' | 'json'}
export interface FactoryOptions {
  cwd?: string;
  sourceName?: string;
  format?: 'hocon' | 'json' | 'properties';
  classpath?: readonly string[];
  includes?: Readonly<Record<string, string>>;
  environment?: Readonly<Record<string, string>>;
  fallbacks?: readonly (string | FallbackSource)[];
  fallbackFiles?: readonly string[];
  fallbackURLs?: readonly string[];
  network?: false | NetworkOptions;
  onRead?: (receipt: ReadReceipt) => void;
}
/** Worker options must be cloneable. onRead callbacks belong to synchronous loads. */
export type AsyncFactoryOptions = Omit<FactoryOptions, 'onRead'> & {onRead?: undefined; signal?: AbortSignal};
export interface ResolveOptions {environment?: Readonly<Record<string, string>>; allowUnresolved?: boolean}
export interface RenderOptions {
  json?: boolean;
  formatted?: boolean;
  comments?: false;
  originComments?: false;
  showEnvVariableValues?: true;
}
export interface GetterOptions {type?: string; unit?: DurationUnit; enumChoices?: readonly string[]}
export interface ChangeRule {path: readonly string[]; kind: 'added' | 'removed' | 'changed'}
export interface ConfigChange {path: string[]; kind: 'added' | 'removed' | 'changed'; before_type: string | null; after_type: string | null}
export interface ChangeReview {accepted: boolean; changes: ConfigChange[]; unexpected: ConfigChange[]}
export interface TransitionRule {path: readonly string[]; beforeSource?: string; afterSource?: string}
export interface TransitionMismatch {path: string[]; kind: string; side: string}
export interface TransitionReview extends ChangeReview {mismatches: TransitionMismatch[]; unusedRules: ChangeRule[]}

export class ConfigError extends Error {
  constructor(result: {error: string; position?: SourcePosition | undefined; problems?: ValidationProblem[] | undefined});
  position: SourcePosition | undefined;
  problems: ValidationProblem[] | undefined;
}

/** Immutable configuration retaining the MoonBit tree. Use the factory methods. */
export class Config {
  private constructor();
  private readonly configState;
  static parse(source: string, options?: FactoryOptions): Config;
  static load(source: string, options?: FactoryOptions): Config;
  static parseFile(filename: string, options?: FactoryOptions): Config;
  static loadFile(filename: string, options?: FactoryOptions): Config;
  static parseURL(url: string, options?: FactoryOptions): Config;
  static loadURL(url: string, options?: FactoryOptions): Config;
  static parseAsync(source: string, options?: AsyncFactoryOptions): Promise<Config>;
  static loadAsync(source: string, options?: AsyncFactoryOptions): Promise<Config>;
  static parseFileAsync(filename: string, options?: AsyncFactoryOptions): Promise<Config>;
  static loadFileAsync(filename: string, options?: AsyncFactoryOptions): Promise<Config>;
  static parseURLAsync(url: string, options?: AsyncFactoryOptions): Promise<Config>;
  static loadURLAsync(url: string, options?: AsyncFactoryOptions): Promise<Config>;
  static fromObject(value: {readonly [key: string]: JsonInput}): Config;
  reviewChanges(next: Config, rules?: readonly ChangeRule[]): ChangeReview;
  reviewTransition(next: Config, rules?: readonly TransitionRule[]): TransitionReview;
  unusedChangeRules(next: Config, rules?: readonly ChangeRule[]): ChangeRule[];
  /** Dynamic getter names do not imply a schema or an inferred result type. */
  get(path: string, options?: GetterOptions): unknown;
  getConfig(path: string): Config;
  getConfigList(path: string): Config[];
  root(): ConfigObject;
  getValue(path: string): ConfigValue;
  getObject(path: string): ConfigObject;
  getList(path: string): ConfigList;
  getObjectList(path: string): ConfigObject[];
  getEnum(path: string, choices: readonly string[]): string;
  getEnumList(path: string, choices: readonly string[]): string[];
  getDuration(path: string, unit?: DurationUnit): string;
  getDurationList(path: string, unit?: DurationUnit): string[];
  getString(path: string): string;
  getBoolean(path: string): boolean;
  getInt(path: string): number;
  getLong(path: string): string;
  getDouble(path: string): DoubleValue;
  getNumber(path: string): ConfigNumber;
  getObjectData(path: string): JsonObject;
  getAnyRef(path: string): JsonValue;
  getListData(path: string): JsonValue[];
  getPeriod(path: string): ConfigPeriod;
  getTemporal(path: string): TemporalAmount;
  getBytes(path: string): string;
  getMemorySize(path: string): string;
  getMilliseconds(path: string): string;
  getNanoseconds(path: string): string;
  getStringList(path: string): string[];
  getBooleanList(path: string): boolean[];
  getIntList(path: string): number[];
  getLongList(path: string): string[];
  getDoubleList(path: string): DoubleValue[];
  getNumberList(path: string): ConfigNumber[];
  getObjectListData(path: string): JsonObject[];
  getAnyRefList(path: string): JsonValue[];
  getBytesList(path: string): string[];
  getMemorySizeList(path: string): string[];
  getMillisecondsList(path: string): string[];
  getNanosecondsList(path: string): string[];
  hasPath(path: string): boolean;
  hasPathOrNull(path: string): boolean;
  getIsNull(path: string): boolean;
  isEmpty(): boolean;
  isResolved(): boolean;
  entrySet(): ConfigEntrySet;
  entrySetData(): JsonObject;
  toJSON(): JsonObject;
  render(options?: RenderOptions): string;
  resolve(options?: ResolveOptions): Config;
  resolveWith(other: Config, options?: ResolveOptions): Config;
  withFallback(other: Config | ConfigValue): Config;
  withValue(path: string, value: JsonInput | ConfigValue): Config;
  withValueSource(path: string, source: string): Config;
  withValueFrom(path: string, other: Config, valuePath: string): Config;
  withoutPath(path: string): Config;
  withOnlyPath(path: string): Config;
  atPath(path: string): Config;
  atKey(key: string): Config;
  withoutKey(key: string): Config;
  withOnlyKey(key: string): Config;
  checkValid(reference: Config, ...paths: string[]): this;
  validationProblems(reference: Config, ...paths: string[]): ValidationProblem[];
}

export class ConfigValue {
  protected constructor();
  private readonly valueState;
  static parse(source: string, options?: FactoryOptions & {resolved?: boolean}): ConfigValue;
  static fromAnyRef(value: JsonInput): ConfigValue;
  valueType(): ValueType;
  unwrapped(): JsonValue;
  render(options?: RenderOptions): string;
  toJSON(): JsonValue;
  equals(other: unknown): boolean;
  hashCode(): number;
  withFallback(other: Config | ConfigValue): ConfigValue;
  atKey(key: string): Config;
  atPath(path: string): Config;
}
export class ConfigObject extends ConfigValue implements Iterable<readonly [string, ConfigValue]> {
  private constructor();
  toConfig(): Config;
  get(key: string): ConfigValue | null;
  containsKey(key: string): boolean;
  size(): number;
  isEmpty(): boolean;
  keySet(): readonly string[];
  values(): readonly ConfigValue[];
  containsValue(value: unknown): boolean;
  entrySet(): readonly (readonly [string, ConfigValue])[];
  [Symbol.iterator](): IterableIterator<readonly [string, ConfigValue]>;
  withValue(key: string, value: ConfigValue): ConfigObject;
  withOnlyKey(key: string): ConfigObject;
  withoutKey(key: string): ConfigObject;
}
export class ConfigList extends ConfigValue implements Iterable<ConfigValue> {
  private constructor();
  get(index: number): ConfigValue;
  size(): number;
  isEmpty(): boolean;
  contains(value: unknown): boolean;
  indexOf(value: unknown): number;
  lastIndexOf(value: unknown): number;
  values(): readonly ConfigValue[];
  [Symbol.iterator](): IterableIterator<ConfigValue>;
  subList(from: number, to: number): readonly ConfigValue[];
}
export class ConfigEntry implements Iterable<string | ConfigValue | null> {
  constructor(key: string | null, value: ConfigValue | null);
  private readonly entryState;
  getKey(): string | null;
  getValue(): ConfigValue | null;
  setValue(value?: unknown): never;
  equals(other: unknown): boolean;
  hashCode(): number;
  [Symbol.iterator](): IterableIterator<string | ConfigValue | null>;
}
export interface ConfigEntryIterator {hasNext(): boolean; next(): ConfigEntry | null; remove(): void}
/** A detached mutable set, including manually added null entries. */
export class ConfigEntrySet implements Iterable<ConfigEntry | null> {
  constructor(entries?: Iterable<ConfigEntry | null>);
  private readonly setState;
  size(): number;
  isEmpty(): boolean;
  contains(entry: unknown): boolean;
  containsAll(entries: Iterable<unknown>): boolean;
  add(entry: ConfigEntry | null): boolean;
  addAll(entries: Iterable<ConfigEntry | null>): boolean;
  remove(entry: unknown): boolean;
  removeAll(entries: Iterable<unknown>): boolean;
  retainAll(entries: Iterable<unknown>): boolean;
  clear(): void;
  toArray(): (ConfigEntry | null)[];
  equals(other: unknown): boolean;
  hashCode(): number;
  iterator(): Readonly<ConfigEntryIterator>;
  [Symbol.iterator](): IterableIterator<ConfigEntry | null>;
}

/** Dynamic wire operations/documents retain their runtime JSON contract. */
export interface LoadOptions extends FactoryOptions {
  getter?: string;
  path?: string;
  enumChoices?: readonly string[];
  unit?: DurationUnit;
  operations?: JsonInput;
  checkValid?: boolean;
  referenceSource?: string;
  validationPaths?: readonly string[];
  document?: boolean;
  steps?: JsonInput;
  probes?: JsonInput;
}
export type AsyncLoadOptions = Omit<LoadOptions, 'onRead'> & {onRead?: undefined; signal?: AbortSignal};
export function load(source: string, options?: LoadOptions): unknown;
export function loadFile(filename: string, options?: LoadOptions): unknown;
export function loadURL(url: string, options?: LoadOptions): unknown;
export function loadAsync(source: string, options?: AsyncLoadOptions): Promise<unknown>;
export function loadFileAsync(filename: string, options?: AsyncLoadOptions): Promise<unknown>;
export function loadURLAsync(url: string, options?: AsyncLoadOptions): Promise<unknown>;
export interface PropertiesObject {[key: string]: string | PropertiesObject}
export function parseProperties(text: string): PropertiesObject;
