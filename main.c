#include <stdio.h>
#include <stdlib.h>

void input(int *data, int n, FILE* file) {
    for (int i = 0; i < n; ++i) {
        if (!file) {
            scanf("%d", &data[i]);
        } else {
            fscanf(file, "%d", &data[i]);
        }
    }
}

void make(const int *from, int *to, int n) {
    int j = 0;
    for (int i = 0; i < n; ++i, ++j) {
        to[j] = from[i];
        if ((to[j] > 0 && to[j] % 10 == 4) || (to[j] < 0 && (-1 * to[j]) % 10 == 4)) {
            to[j] /= 2;
        }
    }
}

void print(int *data, int n, int file) {
    if (!file) {
        for (int i = 0; i < n; ++i) {
            printf("%d ", data[i]);
        }
    } else {
        FILE *fout;
        fout = fopen("output.txt", "w");
        for (int i = 0; i < n; ++i) {
            fprintf(fout, "%d ", data[i]);
        }
        fclose(fout);
    }
}

int main(int argc, __attribute__((unused)) char *argv[]) {
    int n;
    int *from;
    int file = 0;
    if (argc != 1) {
        FILE *F;
        F = fopen("input.txt", "r");
        fscanf(F, "%d", &n);
        from = malloc(n * sizeof(int));
        input(from, n, F);
        fclose(F);
        file = 1;
    } else {
        scanf("%d", &n);
        from = malloc(n * sizeof(int));
        input(from, n, 0);
    }

    int *to = malloc(n * sizeof(int));
    make(from, to, n);
    print(to, n, file);
    free(from);
    free(to);
    return 0;
}
