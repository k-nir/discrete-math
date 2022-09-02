% 使用LaTeX2e语法
\NeedsTeXFormat{LaTeX2e}
% 定义cls信息
\ProvidesClass{math-note}[2022/03/20 v1.0.0 'Math Note' Class]

% 用article作为新cls的基础
% 设定documentclass参数fleqn时，数学公式向左对齐(默认居中对齐)
\LoadClass[a4paper]{article}

% 依赖包
\RequirePackage[margin=1in]{geometry}
% 在文档中使用颜色
% 颜色包的引用应放在较靠前的位置，因为其他包可能会依赖颜色包
% \usepackage{color} (简单颜色)
\RequirePackage[usenames,dvipsnames,svgnames,table]{xcolor}
% 颜色的定义也应放在靠前的位置，因为有些包接受颜色作为参数
% 颜色定义模式有很多种，常用的如下:
%     grey(灰度): 值域: 0-1，值越大越接近白色
%     rgb: 红/绿/蓝，三色值域都为： 0-1，值越大颜色越亮
%     RGB: 与rgb相同，但三色值域为: 0-255
%     HTML: RRGGBB十六进制表示
%     cmyk: 青/品红/黄/黑，四色值域都为: 0-1
\definecolor{palegray}{RGB}{233,233,233}
\definecolor{paleblue}{RGB}{245,245,255}
\colorlet{pinkviolet}{blue!20!purple!50}

\RequirePackage{ctex}
% 段首不缩进时，段与段之间需要使用垂直空格(\\)分开，
% 垂直空格的长度由参数\parskip决定，
% 要改变\parskip的值，使用\setlength{\parskip}{1cm}(设为1cm)。
% 然而，\parskip的值不仅影响垂直空格，还会影响其他地方，例如列表中的间隙；
% 因此，不建议用户直接操作\parskip。
% 使用parskip包可直接达到段首不缩进，段间空行的效果。
\RequirePackage{parskip}
% 段的缩进分成三个部分: 段首行的缩进和段第二行以后的缩进和段最后一行的缩进；
% 段首行的缩进长度由参数\parindent决定(以及有没有使用parskip包)，
% 段第二行到最后一行的缩进由控制词\hangindent决定，
% 例: \hangindent=0.7cm  This paragraph has an extra indentation at the left.
% \hangindent影响其后所有段的缩进，要取消影响，使用\hangafter
% 段最后一行的缩进可以用\parfillskip单独控制。

% 提供adjustwidth环境(修改一部分文本的margin)
\RequirePackage{changepage}
\RequirePackage{amsmath}
% 提供数学专用字体blackboard bold(\mathbb{})
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{IEEEtrantools}
% 绘制彩色box
\RequirePackage[framemethod=tikz]{mdframed}
% KOMA-script，提供labeling环境
\RequirePackage{scrextend}
% 用于自定义枚举(引用此包可使enumerate环境接受可选参数)
\RequirePackage{enumitem}
% 用框体显示页面的布局
% \usepackage{showframe}

% 要插入多行注释，使用verbatim包提供的comment环境。
\RequirePackage{verbatim}
% 自定义标题
\RequirePackage{titlesec}
\titlespacing{\section}{0pt}{2\parskip}{1.5\parskip}
% \titlespacing{\subsection}{0pt}{\parskip}{1.5\parskip}

% TeX提供选择编译语句\iffalse，
% \iffalse和\fi之间的内容会被编译器忽略。
\iffalse
这里的内容会被忽略，
因此ifflase语句也可以用于多行注释。
但要注意，编译器会读取嵌套的ifflase语句。
\fi

% 设置行距，1为默认行距，1.3为一倍半行距，1.6为两倍行距
% \linespread{1.6}

% 消去句尾(即句号后)的额外空格
\frenchspacing

% ******************** 自定义命令与环境 ********************

% 通用缩进和尺寸
\newcommand*{\idt}{15pt}
\newcommand*{\boxmargin}{0.05\linewidth}
\newcommand*{\boxwidth}{0.9\linewidth} % boxwidth = linewidth - 2 * boxmargin
\newcommand*{\roundcorner}{1pt}
\newcommand*{\boxlinewidth}{0.8pt}

% 注释环境
\newenvironment*{notebox}[1]%
{\paragraph{#1:}}%
{}

\surroundwithmdframed[backgroundcolor=palegray,skipabove=\parskip,leftmargin=\boxmargin,rightmargin=\boxmargin,innerleftmargin=\idt,innerrightmargin=\idt,linewidth=0pt,roundcorner=\roundcorner]{notebox}

% 证明环境
\newenvironment*{proofbox}{\begin{proof}[\kaishu \large \it 证明]}{\end{proof}}

\surroundwithmdframed[skipabove=\parskip,leftmargin=\boxmargin,rightmargin=\boxmargin,linewidth=\boxlinewidth,roundcorner=\roundcorner]{proofbox}

% 公式环境
\newenvironment*{formulaebox}%
{\begin{center}\begin{minipage}{\boxwidth}\begin{mdframed}[backgroundcolor=paleblue,linewidth=\boxlinewidth,roundcorner=\roundcorner]\begin{labeling}[：]{AAAAA}}%
{\end{labeling}\end{mdframed}\end{minipage}\end{center}}

\newcommand*{\formula}[2]{\item[\textbf{#1}] #2}

% 将一组box和另一组box分开
\newenvironment*{outerbox}{}{\vspace{\parskip}}

% 数学式中用的逗号
\newcommand*{\mathcomma}{\,,\,}

% 习题集环境
\newenvironment*{exercisesbox}%
{\begin{enumerate}[leftmargin=0pt,topsep=1.5\parskip,itemsep=1.5\parskip]}%
{\end{enumerate}}

% 习题环境
\newenvironment*{exercisebox}%
{\item\begin{mdframed}[leftmargin=\boxmargin,rightmargin=\boxmargin,innertopmargin=2\parskip,innerleftmargin=\boxmargin,innerrightmargin=\boxmargin,linewidth=\boxlinewidth,roundcorner=\roundcorner]}%
{\end{mdframed}}

% 问题环境
% 由于\rule不会自动新起一行，要使\rule成为题目和解答间的分界线，就需要手动使\rule自成一行。
% 直接在\rule之前使用\\的效果并不好，如果题目以显示风格数学式结尾，则\\会导致\rule和题目之间多出一个空白行。
% 此处使用adjustwidth环境使\rule自成一行以避免上述问题。
\newenvironment*{problembox}%
{}%
{\begin{adjustwidth}{0pt}{0pt}\rule{\linewidth}{1pt}\end{adjustwidth}\vspace{\parskip}}
