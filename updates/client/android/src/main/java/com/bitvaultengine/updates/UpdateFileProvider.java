package com.bitvaultengine.updates;

import android.content.ContentProvider;
import android.content.ContentValues;
import android.database.Cursor;
import android.database.MatrixCursor;
import android.net.Uri;
import android.os.ParcelFileDescriptor;
import android.provider.OpenableColumns;
import java.io.File;
import java.io.FileNotFoundException;

/** Exposes only the verified update file, and only through a temporary URI grant. */
public final class UpdateFileProvider extends ContentProvider {
    @Override public boolean onCreate() { return true; }
    private File file(Uri u) throws FileNotFoundException {
        if (getContext() == null || !"/download.apk".equals(u.getPath()) ||
            !(getContext().getPackageName() + ".updatefiles").equals(u.getAuthority()))
            throw new FileNotFoundException();
        File f = new File(new File(getContext().getFilesDir(),"updates"),"download.apk");
        if (!f.isFile()) throw new FileNotFoundException();
        return f;
    }
    @Override public ParcelFileDescriptor openFile(Uri u, String mode) throws FileNotFoundException {
        if (!"r".equals(mode)) throw new FileNotFoundException();
        return ParcelFileDescriptor.open(file(u), ParcelFileDescriptor.MODE_READ_ONLY);
    }
    @Override public String getType(Uri u) { return "application/vnd.android.package-archive"; }
    @Override public Cursor query(Uri u, String[] projection, String selection, String[] args, String sort) {
        try {
            File f = file(u);
            if (projection == null) projection = new String[]{OpenableColumns.DISPLAY_NAME, OpenableColumns.SIZE};
            MatrixCursor cursor = new MatrixCursor(projection);
            Object[] values = new Object[projection.length];
            for (int i=0; i<projection.length; i++) {
                if (OpenableColumns.DISPLAY_NAME.equals(projection[i])) values[i] = "game-update.apk";
                else if (OpenableColumns.SIZE.equals(projection[i])) values[i] = f.length();
            }
            cursor.addRow(values); return cursor;
        } catch (FileNotFoundException e) { return null; }
    }
    @Override public Uri insert(Uri u, ContentValues v) { throw new UnsupportedOperationException(); }
    @Override public int delete(Uri u, String s, String[] a) { throw new UnsupportedOperationException(); }
    @Override public int update(Uri u, ContentValues v, String s, String[] a) { throw new UnsupportedOperationException(); }
}
