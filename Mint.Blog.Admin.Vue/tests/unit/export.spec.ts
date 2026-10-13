import { describe, expect, it } from 'vitest';
import { parseCSVText } from '../../src/utils/export';

describe('CSV import', () => {
  it('preserves quoted newlines, commas, escaped quotes and password whitespace', () => {
    const rows = parseCSVText('\uFEFFname,password\r\n\r\n"a,b\r\nc""d",  secret  \r\nlast,pass', false);
    expect(rows).toEqual([
      { cells: ['name', 'password'], line: 1 },
      { cells: ['a,b\r\nc"d', '  secret  '], line: 3 },
      { cells: ['last', 'pass'], line: 5 },
    ]);
  });
  it('counts LF and CR physical lines and retains empty fields', () => {
    expect(parseCSVText('\nhead,x\r"a\nb",\r\n,,')).toEqual([
      { cells: ['head', 'x'], line: 2 },
      { cells: ['a\nb', ''], line: 3 },
      { cells: ['', '', ''], line: 5 },
    ]);
  });
  it('rejects malformed quotes with the source line', () => {
    expect(() => parseCSVText('head\n\n"unclosed\nvalue')).toThrow('第 3 行');
    expect(() => parseCSVText('head\n"closed"extra')).toThrow('第 2 行');
  });
});
