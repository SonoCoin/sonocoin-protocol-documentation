# Clean out any cached content before starting.
make clean 2>/dev/null

# Background a trigger for initial build of all files.
(sleep 1 && touch source/*.rst) &

sphinx-autobuild -q \
        -p 0 \
        --open-browser \
        --delay 5 \
        --ignore "*.swp" \
        --ignore "*.pdf" \
        --ignore "*.log" \
        --ignore "*.out" \
        --ignore "*.toc" \
        --ignore "*.aux" \
        --ignore "*.idx" \
        --ignore "*.ind" \
        --ignore "*.ilg" \
        --ignore "*.tex" \
        source \
        build/html