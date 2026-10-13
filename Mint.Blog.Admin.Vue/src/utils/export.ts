/**
 * Excel 导入导出工具
 * 基于原生实现，不依赖第三方库，生成标准 CSV 格式
 */

export interface ExportColumn {
  title: string;
  dataIndex: string;
  /** 自定义格式化 */
  render?: (value: unknown, record: unknown) => string;
}

/**
 * 导出数据为 CSV 文件
 */
export function exportToCSV(columns: ExportColumn[], data: unknown[], filename: string = 'export') {
  const BOM = '\uFEFF';
  const header = columns.map((col) => `"${col.title}"`).join(',');
  const rows = data.map((record) =>
    columns
      .map((col) => {
        const recordObj = record as Record<string, unknown>;
        const value = col.render
          ? col.render(recordObj[col.dataIndex], record)
          : (recordObj[col.dataIndex] ?? '');
        return `"${String(value).replace(/"/g, '""')}"`;
      })
      .join(','),
  );

  const csv = BOM + [header, ...rows].join('\n');
  const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
  downloadBlob(blob, `${filename}.csv`);
}

/**
 * 解析 CSV 文件为数据数组
 */
export interface CSVRow {
  cells: string[];
  line: number;
}

export function parseCSVText(text: string, trimCells = true): CSVRow[] {
  text = text.replace(/^\uFEFF/, '');
  const rows: CSVRow[] = [];
  let cells: string[] = [];
  let value = '';
  let quoted = false;
  let closed = false;
  let touched = false;
  let line = 1;
  let startLine = 1;
  const pushCell = () => {
    cells.push(trimCells ? value.trim() : value);
    value = '';
    closed = false;
  };
  const pushRow = () => {
    if (touched) {
      pushCell();
      rows.push({ cells, line: startLine });
    }
    cells = [];
    value = '';
    closed = false;
    touched = false;
  };
  for (let i = 0; i < text.length; i++) {
    const char = text[i];
    const newline = char === '\r' || char === '\n';
    if (newline) {
      const ending = char === '\r' && text[i + 1] === '\n' ? '\r\n' : char;
      if (ending.length === 2) i++;
      if (quoted) value += ending;
      else pushRow();
      line++;
      if (!quoted) startLine = line;
      continue;
    }
    if (quoted) {
      if (char === '"' && text[i + 1] === '"') {
        value += '"';
        i++;
      } else if (char === '"') {
        quoted = false;
        closed = true;
      } else value += char;
    } else if (char === ',') {
      touched = true;
      pushCell();
    } else if (char === '"' && value.length === 0 && !closed) {
      touched = true;
      quoted = true;
    } else {
      if (closed || char === '"') throw new Error(`CSV 第 ${line} 行：引号格式错误`);
      value += char;
      if (char.trim()) touched = true;
    }
  }
  if (quoted) throw new Error(`CSV 第 ${startLine} 行：引号未闭合`);
  pushRow();
  return rows;
}

export function parseCSVRecords(file: File, trimCells = true): Promise<CSVRow[]> {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.onload = (e) => {
      try {
        resolve(parseCSVText((e.target?.result ?? '').toString(), trimCells));
      } catch (err) {
        reject(err);
      }
    };
    reader.onerror = reject;
    reader.readAsText(file, 'utf-8');
  });
}

export async function parseCSV(file: File, trimCells = true): Promise<string[][]> {
  return (await parseCSVRecords(file, trimCells)).map((row) => row.cells);
}

/**
 * 导出数据为 JSON 文件
 */
export function exportToJSON(data: unknown[], filename: string = 'export') {
  const json = JSON.stringify(data, null, 2);
  const blob = new Blob([json], { type: 'application/json;charset=utf-8;' });
  downloadBlob(blob, `${filename}.json`);
}

function downloadBlob(blob: Blob, filename: string) {
  const url = URL.createObjectURL(blob);
  const link = document.createElement('a');
  link.href = url;
  link.download = filename;
  document.body.appendChild(link);
  link.click();
  document.body.removeChild(link);
  URL.revokeObjectURL(url);
}
