export const samples: {name: string; parts: string[]; expression: string}[] = [
  {
    "name": "simple",
    "parts": [
      "service",
      "port"
    ],
    "expression": "service.port"
  },
  {
    "name": "literal-dot",
    "parts": [
      "service",
      "a.b"
    ],
    "expression": "service.\"a.b\""
  },
  {
    "name": "empty-components",
    "parts": [
      "",
      ""
    ],
    "expression": "\"\".\"\""
  },
  {
    "name": "unicode-and-escapes",
    "parts": [
      "中文.😀",
      "line\nbreak",
      "quote\"\\"
    ],
    "expression": "\"中文.😀\".\"line\\nbreak\".\"quote\\\"\\\\\""
  },
  {
    "name": "numeric-dash",
    "parts": [
      "1",
      "a-b",
      "_"
    ],
    "expression": "1.a-b._"
  },
  {
    "name": "depth32",
    "parts": [
      "p0",
      "p1",
      "p2",
      "p3",
      "p4",
      "p5",
      "p6",
      "p7",
      "p8",
      "p9",
      "p10",
      "p11",
      "p12",
      "p13",
      "p14",
      "p15",
      "p16",
      "p17",
      "p18",
      "p19",
      "p20",
      "p21",
      "p22",
      "p23",
      "p24",
      "p25",
      "p26",
      "p27",
      "p28",
      "p29",
      "p30",
      "p31"
    ],
    "expression": "p0.p1.p2.p3.p4.p5.p6.p7.p8.p9.p10.p11.p12.p13.p14.p15.p16.p17.p18.p19.p20.p21.p22.p23.p24.p25.p26.p27.p28.p29.p30.p31"
  }
];
