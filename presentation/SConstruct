# -*- mode: python -*-
# SCons build file

import os
import subprocess
from tempfile import TemporaryFile
import shutil

PRESENTATION_NAME = 'lisp-intro.pdf'


def git_current_branch():
    git_branch_output = subprocess.Popen(
        ['git', 'branch'],
        stdout=subprocess.PIPE).communicate()[0]
    branches = git_branch_output.splitlines()
    current_branch = filter(lambda b: b.startswith('*'),
                            branches)[0].split(' ')[1]
    return current_branch


def upload_to_gh_pages(target, source, env):
    current_branch = git_current_branch()
    with TemporaryFile() as temp_file:
        with open(RESUME_PDF_NAME) as pdf_file:
            shutil.copyfileobj(pdf_file, temp_file)
        subprocess.check_call(['git', 'checkout', 'gh-pages'])
        temp_file.seek(0)
        with open(RESUME_PDF_NAME, 'w') as pdf_file:
            shutil.copyfileobj(temp_file, pdf_file)
    subprocess.check_call(['git', 'add', PRESENTATION_NAME])
    subprocess.check_call(['git', 'commit', '-m', 'Updated presentation.'])
    subprocess.check_call(['git', 'push', 'origin', 'gh-pages'])
    subprocess.check_call(['git', 'checkout', current_branch])
    return 0


env = Environment(ENV={'PATH': os.environ['PATH']})

# Use LuaTeX instead of pdfTeX.
env.Replace(PDFLATEX='lualatex')

# Use Biber instead of BiBTeX.
env.Replace(BIBTEX='biber')

# Enable SyncTeX. This is personal, but I use it, and I would
# recommend it to everybody.
env.AppendUnique(PDFLATEXFLAGS='-synctex=1')

# Shell escape. Needed by minted and dot2tex to name a few.
env.AppendUnique(PDFLATEXFLAGS='-shell-escape')

# Look in standard directory ~/texmf for .sty files.
env.SetDefault(TEXMFHOME=os.path.join(os.environ['HOME'], 'texmf'))

pdf = env.PDF(target=PRESENTATION_NAME,source='lisp-intro.tex')

SConscript('dot/SConscript', exports='env')
Import('*')

env.Depends(pdf, [cons_png, abc_png, abcd_png])
Default(pdf)

env.Command('upload', [pdf], upload_to_gh_pages)
