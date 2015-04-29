using System;

namespace MusicStore.Components
{
    /// <summary>
    /// Provides access to the normal system clock.
    /// </summary>
    public class SystemClock : ISystemClock
    {
        /// <inheritdoc />
        public DateTime UtcNow
        {
            get
            {
                // The clock measures whole seconds only, to have integral expires_in results, and
                // because milliseconds do not round-trip serialization formats
                DateTime utcNow = DateTime.UtcNow;
                return utcNow.AddMilliseconds(-utcNow.Millisecond);
            }
        }
    }
}
